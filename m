Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283200AbRLDOo1>; Tue, 4 Dec 2001 09:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283684AbRLDOnK>; Tue, 4 Dec 2001 09:43:10 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:30094 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283129AbRLDMdf>; Tue, 4 Dec 2001 07:33:35 -0500
Message-ID: <3C0CC182.B65B6A52@wanadoo.fr>
Date: Tue, 04 Dec 2001 13:28:50 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: 2.5.1-pre5 AudioCD with cdrom modules
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What may cause an AudioCD no being recocognized at first attempt but
only after unloading/reloading the modules ide-cd cdrom ?

I'm testing 2.5.1-pre5 + devfs-patch-v202.

My CRD-8240B is known as /dev/cdroms/cdrom0 in fstab, to mount it
manually on /cdrom, and in the gnome CD player gtcd preferences panel.

ide-cd and cdrom are loaded at boot time (i don't need that, 2.4.16 does
it as well). After loging in i can mount /cdrom but if it is an AudioCD
gtcd tells me 'no disc'.

After rmmod ide-cd cdrom, gtcd finds the AudioCD OK.

This doesn't happen on plain 2.4.16

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
