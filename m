Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUGAKoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUGAKoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUGAKoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 06:44:39 -0400
Received: from duchamp.tecgraf.puc-rio.br ([139.82.85.1]:55557 "EHLO
	tecgraf.puc-rio.br") by vger.kernel.org with ESMTP id S264412AbUGAKoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 06:44:37 -0400
Date: Thu, 1 Jul 2004 07:49:33 -0300
From: Andre Costa <costa@tecgraf.puc-rio.br>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: linux-kernel@vger.kernel.org, tomstdenis@yahoo.com, nick@ukfsn.org
Subject: Re: 2.4.26: IDE drives become unavailable randomly
Message-Id: <20040701074933.722e40e4.costa@tecgraf.puc-rio.br>
In-Reply-To: <Pine.GSO.4.21.0407010446090.2056-100000@dirac.phys.uwm.edu>
References: <40E2E7EF.15243.10093E4E@localhost>
	<Pine.GSO.4.21.0407010446090.2056-100000@dirac.phys.uwm.edu>
Organization: TecGraf
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me on any replies, I am not subscribed to this list)

On Thu, 1 Jul 2004 04:48:30 -0500 (CDT)
Bruce Allen <ballen@gravity.phys.uwm.edu> wrote:

> > I was getting this problem, and advice from smartmontools people was
> > to clean out the box and reseat all cables etc.  Seemed to work for 
> > me on the box at work with this DMA timeout issue - BTW, always 
> > happened at idle, like 2:15am in the middle of the night etc.
> > 
> > Reference: 
> > http://sourceforge.net/mailarchive/message.php?msg_id=8660397
> > http://sourceforge.net/mailarchive/forum.php?thread_id=4908273&forum_i
> > d=12495
> 
> An additional reference. See the entry that starts 'System freezes
> under heavy load" in:
> http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?view=markup
> 
> Cheers,
> 	Bruce

Thks, folks, I wouldn't really suspect of bad cables/PSU, this was an
eye-opener. I have just opened the box and reseated the 80-wire IDE
cable to my hda device, and I will consider replacing it, just in case.
The PSU is brand new, 450W -- although it could be bad quality, I will
try to check this out.

BTW: Nick, I missed your msg because you didn't cc me. My hda also
usually gets disconnected at early hours in the morning, as you pointed
out. I arrived today to work and it had happened again =/ Last entry
on/var/log/messages was around 1:30am, and it was about a NFS mount that
had expired.

Best,

Andre

-- 
Andre Oliveira da Costa
(costa@tecgraf.puc-rio.br)
