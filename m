Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbVKQA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbVKQA37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbVKQA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:29:59 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:50630 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161019AbVKQA36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:29:58 -0500
Date: Thu, 17 Nov 2005 01:28:15 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051117002815.GC11128@wohnheim.fh-wedel.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de> <20051117000654.GA11128@wohnheim.fh-wedel.de> <437BB7D1.2090109@wolfmountaingroup.com> <437BB8A3.9030701@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437BB8A3.9030701@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 November 2005 15:54:27 -0700, Jeffrey V. Merkey wrote:
> Jeffrey V. Merkey wrote:
> >>
> >The SCSI layer needs to be checked.  I reproduced another crash on 
> >today on an older Niksun box running off the end of the stack.
> >
> It's somewhere in the scanning code.  There's a case where it runs off 
> the end of the stack.  Check the compaq drivers for SATA as well, they 
> also crash in a similiar place during bus scan.  Both occurred during 
> bootup, so I wasn't able to get a log of the particulars.  Should be 
> easy to reproduce.  Compaq Presario 2200.

Do you have a backtrace for these?  Real-life problem tend to generate
more attention than theoretical results based on code checkers.

Jörn

-- 
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle
