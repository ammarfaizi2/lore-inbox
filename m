Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUBEMbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBEMbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:31:25 -0500
Received: from mail1.upco.es ([130.206.70.227]:28291 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S265152AbUBEMbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:31:23 -0500
Date: Thu, 5 Feb 2004 13:31:21 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: PMDISK wins other suspends on my VAIO PGC-FX701
Message-ID: <20040205123121.GD5716@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know if that could be of interest, but...

I tried (with kernel 2.6.1) the three flavors of suspend-to-disk available
around on my sony vaio PGCFX701 (athlon PowerNow, VIA chipset). The only one
that works(*) is PMDISK from standard kernel; nor swsusp (standard) neither
swsusp2 (I tried with 2.0rc7 release) could suspend my box. 

If anyone is interested in more data and/or test, tell me, I can try things
for you. I never used a serial console, but I have a little psion thing that
I think I can use for it... 

Romano 

(*) well, unloading usb and alsa modules before suspend and reloading them
afterward. I read in l-k that module unloading shouldn't be needed... I will
try 2.6.2-mm1 which has alsa and usb updates, to see if I can avoid it. 

PD S3 suspend does not work... 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
