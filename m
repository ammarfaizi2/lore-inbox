Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265817AbRF2Jhc>; Fri, 29 Jun 2001 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbRF2JhQ>; Fri, 29 Jun 2001 05:37:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39940 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265803AbRF2JhJ>; Fri, 29 Jun 2001 05:37:09 -0400
Subject: Re: directory order of files
To: edmundo@rano.org (Edmund GRIMLEY EVANS)
Date: Fri, 29 Jun 2001 10:36:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010629101818.A13817@rano.org> from "Edmund GRIMLEY EVANS" at Jun 29, 2001 10:18:18 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FuhY-0008QC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With Linux ext2, and some other systems, when you create files in a
> new directory, the file system remembers their order:

No - it merely seems too. 

> $ touch one two three four
> $ ls -U
> one  two  three  four

Then try 'rm three; touch five'

> 
> (1) Is there any standard that says a system should behave this way?
> Is there any software that depends on this behaviour?

The order is arbitary. 

