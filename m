Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEaAIJ>; Thu, 30 May 2002 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSEaAII>; Thu, 30 May 2002 20:08:08 -0400
Received: from pensacola.gci.com ([205.140.80.79]:54801 "EHLO
	pensacola.gci.com") by vger.kernel.org with ESMTP
	id <S310206AbSEaAII>; Thu, 30 May 2002 20:08:08 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31508EC0CD6@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Dave Jones <davej@suse.de>
Subject: RE: [PATCH] x86 cpu selection (first hack)
Date: Thu, 30 May 2002 16:07:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones replied to 
>Jeff Garzik who wrote:
> 
>> [I] wonder if making the CPU features selectable is useful? 
>> i.e. provide an actual config option for MMX memcpy, F00F bug,
>> WP, etc. Normal (current) logic is to look at the cpu selected,
>> and deduce these options.
> 
> J.A's comment that most people compiling kernels shouldn't 
> need to know what bugs their CPU has before they pick it is
> a good one imo
> 

Perhaps a comprimise could be made?

Envision a config option where you would have 'expert' choices
for MMX, FOOF, WP, etc.

bool CONFIG_ENABLE_EXPERT_CPU_CHOICES

Leaving this alone would hide the individual tweaks under the
guise of 'least-common-denominator' choices previously suggested.

