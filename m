Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSKZW3S>; Tue, 26 Nov 2002 17:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKZW3S>; Tue, 26 Nov 2002 17:29:18 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:13789 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261368AbSKZW3R>; Tue, 26 Nov 2002 17:29:17 -0500
Date: Tue, 26 Nov 2002 14:36:26 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [RFC] hangcheck-timer module
Message-ID: <20021126223626.GG13653@nic1-pc.us.oracle.com>
References: <20021121201931.GH770@nic1-pc.us.oracle.com> <20021126133547.GA1268@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126133547.GA1268@zaurus>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 02:35:47PM +0100, Pavel Machek wrote:
> Would it make it more sense for other machines
> to "kill" offending machine (cut power or press reset)?

	There is no solution that is general and inexpensive.  STONITH
is as close as it gets, and we don't have support for that.  On other
platforms where the shared disk is on FC, the device driver supports
fencing nodes from the switch.
	That said, this module isn't exclusively useful to a
cluster+shared disk environment.  If it were, I couldn't see generic
inclusion.  This code is useful in many other situations.

Joel

-- 

Life's Little Instruction Book #313

	"Never underestimate the power of love."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
