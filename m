Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbSADVvm>; Fri, 4 Jan 2002 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSADVve>; Fri, 4 Jan 2002 16:51:34 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:39581 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S285065AbSADVvV>; Fri, 4 Jan 2002 16:51:21 -0500
Date: Fri, 4 Jan 2002 22:50:40 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: i810_audio.c .text.exit reference in 2.4.17
Message-ID: <20020104215040.GA3020@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to mention that i810_audio.c suffers from referencing a
symbol in .text.exit(i810_remove), too, with the usual symptoms.

If that is still interesting, I don't know what fixes are in the work.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
