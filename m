Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSD0STr>; Sat, 27 Apr 2002 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSD0STq>; Sat, 27 Apr 2002 14:19:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314330AbSD0STp>; Sat, 27 Apr 2002 14:19:45 -0400
Subject: Re: linux-2.5.x-dj and SCSI error handling.
To: Andries.Brouwer@cwi.nl
Date: Sat, 27 Apr 2002 19:38:23 +0100 (BST)
Cc: davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200204271630.g3RGUgF04840.aeb@smtp.cwi.nl> from "Andries.Brouwer@cwi.nl" at Apr 27, 2002 06:30:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171X5T-0000Fi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> device resets, bus resets making the machine entirely
> unusable during this time, and often causing an oops
> in the end, killing off the machine entirely.
> However, I have no recent experiences here.)

The old scsi eh code is dire, the new scsi eh code is currently merely
bad. However the interface for the newer scsi_eh is probably right, which 
is the important bit
