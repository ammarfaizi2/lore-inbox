Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319040AbSHFKOP>; Tue, 6 Aug 2002 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSHFKOP>; Tue, 6 Aug 2002 06:14:15 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:12292 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S319040AbSHFKOO>;
	Tue, 6 Aug 2002 06:14:14 -0400
Message-Id: <200208061120.GAA01735@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: rz@linux-m68k.org, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 10:10:59 +0200."
             <20020806101059.51ae728d.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 06:20:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
>                         if (current->pgrp != -arg &&
>                                 current->pid != arg &&
>                                 !capable(CAP_KILL)) return(-EPERM); 

What's the problem here?  This will let UML do F_SETOWN as well.

				Jeff

