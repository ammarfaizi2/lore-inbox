Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSFLKrl>; Wed, 12 Jun 2002 06:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFLKrk>; Wed, 12 Jun 2002 06:47:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:7697 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317359AbSFLKrk>;
	Wed, 12 Jun 2002 06:47:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: mingo@elte.hu
Cc: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>, linux-kernel@vger.kernel.org,
        xsdg <xsdg@openprojects.net>
Subject: Re: [patch] early printk. (was: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs) 
In-Reply-To: Your message of "Wed, 12 Jun 2002 08:29:30 +0200."
             <Pine.LNX.4.44.0206120825510.4043-100000@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 20:47:25 +1000
Message-ID: <25248.1023878845@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002 08:29:30 +0200 (CEST), 
Ingo Molnar <mingo@elte.hu> wrote:
>On Wed, 12 Jun 2002, Keith Owens wrote:
>> Try http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2
>
>you might as well try the attached early_printk() patch, it's slightly
>easier to use than a one-char macro. But the goal is the same.

The main difference is that VIDEO_CHAR is easy to do from assembler as
well, it is just a movb instruction that does not affect any registers.

