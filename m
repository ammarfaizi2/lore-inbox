Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUAUP6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 10:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAUP6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 10:58:40 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:2246 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263606AbUAUP6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 10:58:39 -0500
Date: Wed, 21 Jan 2004 16:43:15 +0100
From: GCS <gcs@lsc.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly ipv6 related
Message-ID: <20040121154315.GA10508@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org> <400D083F.6080907@aitel.hist.no> <20040120175408.GA12805@lsc.hu> <20040120102302.47fa26cd.akpm@osdl.org> <400E47CB.5030000@aitel.hist.no> <20040121142802.GA8840@lsc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040121142802.GA8840@lsc.hu>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:28:02PM +0100, GCS <gcs@lsc.hu> wrote:
> On Wed, Jan 21, 2004 at 10:35:07AM +0100, Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > I have ipv6 compiled into the kernel, others with the same problem
> > seems to have this common factor.  
>  I have switched off CONFIG_IPV6, and now it boots.
 I have narrowed it down to 'CONFIG_IPV6_PRIVACY=y'. Can you try to
disable only this one - if you even have it, and check the boot?
Cheers,
GCS
