Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293759AbSCAU4A>; Fri, 1 Mar 2002 15:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293757AbSCAUzv>; Fri, 1 Mar 2002 15:55:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25872 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293755AbSCAUzg>;
	Fri, 1 Mar 2002 15:55:36 -0500
Message-ID: <3C7FEAC9.DDA73021@mandrakesoft.com>
Date: Fri, 01 Mar 2002 15:55:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] moving task_struct
In-Reply-To: <Pine.LNX.4.21.0203012040220.32042-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below simply moves task_struct into its own header file.
> This makes thread_info and task_struct indepedent from sched.h and will 
> allows archs to decide themselves the dependencies between these
> structures.

nice...   In addition to your second patch, this first patch may be a
small step in paving the way for further unraveling of nasty include
dependencies.

Regards,

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
