Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWAIQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWAIQuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWAIQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:50:18 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:20445 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWAIQuQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:50:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPb+AhEEB0fOAUm0n3L/cY75CdxssxfsBPUx50bzzChWJWYuLI1VsLOwGa78Abcs9FmNYXeKRBwH4BBQ7VNbO8krby3eauIa8bP07YqMW9aWcqTvOPMoPql+91gTPcPwi7y+ZUYvXyPP7Ng56jKD5rRLE6dmJJlJ4fGP1eP2TUs=
Message-ID: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com>
Date: Mon, 9 Jan 2006 11:50:14 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Cc: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
In-Reply-To: <Pine.LNX.4.44L0.0601091026200.5734-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200601090126.56831.dtor_core@ameritech.net>
	 <Pine.LNX.4.44L0.0601091026200.5734-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 9 Jan 2006, Dmitry Torokhov wrote:
>
> > On Sunday 08 January 2006 16:23, Martin Bretschneider wrote:
> > > Hello,
> > >
> > > Jens Nödler who has got the same motheboard (Gigabyte GA-K8NF-9 with
> > > nforce4 chipset) can confirm my problem. But he found out that the
> > > keyboard connected to the ps/2 port does work with kernel 2.6.15 if
> > > "USB keyboard support" is disabled in the BIOS.
> > >
> >
> > Ok, I an getting enough reports to conclude that the new usb-handoff
> > code does not seem to be working. Let's try CCing USB list and other
> > parties involved :)
> >
> > Greg, Alan, any ideas?
>
> It would be nice to know which part of the usb-handoff code causes the
> problem.

Well, it's not handoff code causing problems per se, it's just that it
does not look like it performs handoff. If it did then disabling USB
legacy emulation in BIOS would have no effect, right?

--
Dmitry
