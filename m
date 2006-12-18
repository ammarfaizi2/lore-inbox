Return-Path: <linux-kernel-owner+w=401wt.eu-S1753284AbWLRAKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbWLRAKl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 19:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWLRAKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 19:10:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3869 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753284AbWLRAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 19:10:40 -0500
Date: Mon, 18 Dec 2006 01:10:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Joerg Heckenbach <joerg@heckenbach-aw.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: drivers/media/video/usbvision/usbvision-video.c: negative array
Message-ID: <20061218001039.GR10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

index
Reply-To: 
Fcc: =sent-mail

The Coverity checker spotted that in usbvision_v4l2_read(), the variable 
"frmx" is never assigned any value different from -1, but it's used an 
an array index in "usbvision->frame[frmx]".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

