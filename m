Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSH1T6s>; Wed, 28 Aug 2002 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318936AbSH1T6s>; Wed, 28 Aug 2002 15:58:48 -0400
Received: from holomorphy.com ([66.224.33.161]:8064 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318933AbSH1T6r>;
	Wed, 28 Aug 2002 15:58:47 -0400
Date: Wed, 28 Aug 2002 13:03:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd_bh() is entered during kbd_init()
Message-ID: <20020828200306.GA888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20020828004040.GA2516@holomorphy.com> <20020827.180735.00300710.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020827.180735.00300710.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 27 Aug 2002 17:40:40 -0700
>    kbd_init() needs to disable interrupts.

On Tue, Aug 27, 2002 at 06:07:35PM -0700, David S. Miller wrote:
> That won't cure the problem on SMP.

Seemed to fix it on a 16x. I believe the kernel isn't running anything on
the secondaries yet at that point. Working alternatives are, of course,
welcome.


Cheers,
Bill
