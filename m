Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWA2Ulc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWA2Ulc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWA2Ulc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:41:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39059 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751170AbWA2Ulc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:41:32 -0500
Date: Sun, 29 Jan 2006 21:41:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, bzolnier@gmail.com,
       mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
In-Reply-To: <20060129112613.GA29356@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That's what I believe to be cdrecord/libscg bugs:
>
>1) libscg or cdrecord does not automatically probe all available
>   transports, but only SCSI:

This one is IMO just "a missing feature", as I can get the ATA/PI list using
  cdrecord -dev=ATA: -scanbus



Jan Engelhardt
-- 
