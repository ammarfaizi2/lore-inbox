Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVDXNfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVDXNfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 09:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVDXNfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 09:35:15 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:55502 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262330AbVDXNfH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 09:35:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VM6jXX9HL0mpjvmHMbsQJqOlVWSeSaP5Lh2+sAdl+zXphJBthb4rSgMVSQ/AvdLJgPkGbmINc3wIt5Wp04Ea+qTalRbIAEgp/HSEEB8X8sBJmLI5dc5aQPQwjP05ts2GsEA/hBU7UW0Xcw7k4HTzvAmfrocTTd5+Te6rs+MuCLQ=
Message-ID: <2a4f155d0504240635a325a48@mail.gmail.com>
Date: Sun, 24 Apr 2005 16:35:06 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Cc: Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org,
       ak@suse.de
In-Reply-To: <200504240903.31377.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200504240008.35435.kernel-stuff@comcast.net>
	 <1114332119.916.1.camel@localhost.localdomain>
	 <200504240903.31377.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.12-rc3 here on amd64 and I don't see any reboots. So it
might be config dependent.


On 4/24/05, Ed Tomlinson <tomlins@cam.org> wrote:
> On Sunday 24 April 2005 04:41, Alexander Nyberg wrote:
> > sön 2005-04-24 klockan 00:08 -0400 skrev Parag Warudkar:
> > > While running a 32 bit Java program 2.6.12-rc3 rebooted spontaneously
> leaving 
> > > a corrupt partition table and disk with errors. There was nothing in
> dmesg 
> > > (no oops/panic) except some -MARK- entries during the reboot.
> > > 
> > 
> > Is this reproducible? If so, can you give a detailed description of how.
> 
> I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly. 
> Nothing
> shows up on a serial console...  Think something is seriously wrong with
> x86_64 in rc3.
> That being said its possible its fixed in HEAD by.
> 
> [PATCH] x86_64: fix new out of line put_user()
> [PATCH] x86_64: Bug in new out of line put_user()
> 
> some people have reported reversing (in -mm)
> 
> sched-unlocked-context-switches.patch
> 
> Helps too.
> 
> Ed Tomlinson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Time is what you make of it
