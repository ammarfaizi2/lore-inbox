Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSCCRg2>; Sun, 3 Mar 2002 12:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCCRgS>; Sun, 3 Mar 2002 12:36:18 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:33994 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287858AbSCCRgN>; Sun, 3 Mar 2002 12:36:13 -0500
Date: Sun, 3 Mar 2002 18:33:41 +0100
From: Wolfram Schlich <lists@schlich.org>
To: linux-kernel@vger.kernel.org
Subject: Re: strange hang with promise ide and 2.4.18
Message-ID: <20020303173341.GO28780@lan.berghof.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020302134523.GA1022@mur.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020302134523.GA1022@mur.org.uk>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/CD4DF205, http://wolfram.schlich.org/wschlich.asc
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Operating-System: Linux 2.4.17-grsec-1.9.3a SMP i686
X-Uptime: 6:28pm up 2 days, 18:38, 1 user, load average: 2.00, 2.00, 1.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 01:45:23PM +0000, rob@mur.org.uk wrote:
> Hi
> 
> I have the following:
> 
> 00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
> 
> I did have three of these cards, but I gave one away. The kernel
> sometimes hangs during boot with no oops or panic. It depends on the
> number of cards installed and how many disks are attached. If all 3
> are installed and all channels have 1 disk, or 2 cards are installed
> with a disk on each channel, the boot hangs. If 3 cards are installed,
> but only 5 disks are attached, it doesn't hang. if 1 card is installed
> with 2 disks attached, it doesn't hang.

Have you tried Andre Hedricks IDE-patch from
http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.18/ ?

You could also try to enable CONFIG_PDC202XX_BURST, but I'm not sure.
-- 
Mit freundlichen Gruessen / Yours sincerely
Wolfram Schlich; Berghof, D-56626 Andernach-Kell; +49-(0)2636-941194;
