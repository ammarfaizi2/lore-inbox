Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbULZQpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbULZQpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbULZQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:45:11 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:14466 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261706AbULZQo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:44:58 -0500
Date: Sun, 26 Dec 2004 16:45:21 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to hang 2.6.9 using serial port and FB console
Message-ID: <20041226164521.GB5529@beton.cybernet.src>
References: <20041226143118.GA5169@beton.cybernet.src> <20041226145334.GC1668@gallifrey> <20041226162426.GC5859@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226162426.GC5859@beton.cybernet.src>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out another bit of information:

When the kernel is hanged up and I remove the infra dongle (so that
nothing is sent towards the computer anymore for sure), the kernel stays
hanging.

This is therefore a final proof that it is not caused by sending breaks.
Dongle that is not present can't send breaks anymore ;-)

Cl<
On Sun, Dec 26, 2004 at 04:24:26PM +0000, Karel Kulhavy wrote:
> On Sun, Dec 26, 2004 at 02:53:35PM +0000, Dr. David Alan Gilbert wrote:
> > Hi Karel,
> >   I wonder - is the board sending a 'break' signal to the PC? I just
> > remember years ago you could almsot lock machines up by constantly
> > sending break.
> 
> But in this case the kernel doesn't care if you run it on a console without
> a fancy background picture and hangs when you run it on a fancy background
> picture.
> 
> The picture is what seems to be evil here.
> 
> Cl<
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
