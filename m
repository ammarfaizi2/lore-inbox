Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288788AbSA0WI0>; Sun, 27 Jan 2002 17:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSA0WIP>; Sun, 27 Jan 2002 17:08:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288788AbSA0WH5>; Sun, 27 Jan 2002 17:07:57 -0500
Subject: Re: PROBLEM: 2.4.17 crashes (VM bug?) after heavy system load
To: grundig@teleline.es (Diego Calleja)
Date: Sun, 27 Jan 2002 22:20:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml), guido.leenders@invantive.com
In-Reply-To: <20020127220437Z288780-13996+13092@vger.kernel.org> from "Diego Calleja" at Jan 27, 2002 10:19:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UxfD-0002uK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 27 ene 2002, 22:49:17, Guido Leenders wrote:
> > 
> > [1.] One line summary of the problem:    
> > 
> > Especially during times of heavy I/O, swapping and CPU processing, the
> > OS crashes with an Oops.
> I think andrea's patches should be applied into stable mainline NOW. 

Its up to Andrea to break up his patches and feed them to Marcelo as he
has been asked. It also won't make any odds to this trace I suspect. 

Trying 2.4.18pre7 or applying the LRU patch to 2.4.17 that Ben LaHaise did
should sort most of the 2.4.17 crashes out
