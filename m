Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283223AbRK2Nj4>; Thu, 29 Nov 2001 08:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283225AbRK2Njm>; Thu, 29 Nov 2001 08:39:42 -0500
Received: from firewall.esrf.fr ([193.49.43.1]:44471 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S283223AbRK2Njb>;
	Thu, 29 Nov 2001 08:39:31 -0500
Date: Thu, 29 Nov 2001 14:38:44 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: linux-kernel@vger.kernel.org
Subject: umounts and sync
Message-ID: <20011129143844.B3221@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(re-)hello everyone,
I'm currently writing a script for hotplug ieee1394 hard drives.
I'm encountering troubles with something:
my hotplug agent launch a script when you unplug the disk.
This script calls umount.
Am I going to loose datas (as the umount and stuff which are written on
the HD by umount won't be written because the disk isn't here anymore)?
Do you have a solution to avoid this ? 
mounting with sync option slows the disk.
I can also do a script: if no activity during 5 sec on the disk, do
sync. (Is it the "sync" command I need to do this ?)
As usually: Thanks for any help.
        Sam
