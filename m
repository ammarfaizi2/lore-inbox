Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVEJNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVEJNLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEJNLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:11:35 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:29197 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261628AbVEJNLc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:11:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Knn35+N/71yCsDuEimUP6oCVTJwHr4svEI41l25DAgylneOi6r4f3b1ZQfehZHaPgPLSFuuMEGWMz+sOfgTKMyawd5dYzgdJvvEWwQBg4d46I8GhDf8QIAuzmaclgERPkurOtj4bDHQJsL+K96rfheFYLZCKIibO/UZdUiwdV6c=
Message-ID: <2cd57c9005051006117d0c343@mail.gmail.com>
Date: Tue, 10 May 2005 21:11:31 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: kexec?
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200505101215.48993.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050508202050.GB13789@charite.de>
	 <20050509183428.6d7934a6.rddunlap@osdl.org>
	 <2cd57c9005051000004c57050@mail.gmail.com>
	 <200505101215.48993.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Borislav Petkov <petkov@uni-muenster.de> wrote:
> I've been doing some kexec tests (as described in Documentation/kdump.txt) too
> but can't get to load the image and get similar error messages. Let me know
> if you need more info about the hardware. The first_kernel was booted with
> "crashkernel=64M@16M" and the 16M value was configured into the second during
> kconfig in "Physical address where the kernel is loaded" as 0x1000000.
> 
> [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1 maxcpus=1
> init 1"

 kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
after "Starting new kernel"

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
