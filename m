Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143429AbRELAZm>; Fri, 11 May 2001 20:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143428AbRELAZc>; Fri, 11 May 2001 20:25:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143427AbRELAZU>; Fri, 11 May 2001 20:25:20 -0400
Subject: Re: OOPS on 2.4.4-ac4
To: ingo@plato.prima.de (Ingo Renner)
Date: Sat, 12 May 2001 01:21:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010512014854.ingo@plato.prima.de> from "Ingo Renner" at May 12, 2001 01:48:54 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yNAQ-0001sM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> computer during this time.=20
> So I don't know if this has to do with the new networkcard, the new NVIDIA
> Driver 0.9-769 I installed yesterday with XFree 4.3 or something else. The =

> -----------
> Module                  Size  Used by
> via82cxxx_audio        16800   2  (autoclean)
> soundcore               3600   2  (autoclean) [via82cxxx_audio]
> ac97_codec              8560   0  (autoclean) [via82cxxx_audio]
> NVdriver              626480  12  (autoclean)
> vmnet                  16224   3
> vmmon                  18224   0
> dmfe                    9408   1  (autoclean)

You are using binary only drivers. We can't debug them (least of all a 625K
module thats almost the size of the kernel).  Duplicate the problems on a boot
that never loaded vmware or nvdriver and its interesting, otherwise take it
up with vmware and nvidia - they have our source we dont have theirs

