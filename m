Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290224AbSAXATI>; Wed, 23 Jan 2002 19:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290225AbSAXAS6>; Wed, 23 Jan 2002 19:18:58 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:60933 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S290224AbSAXASt>; Wed, 23 Jan 2002 19:18:49 -0500
Date: Thu, 24 Jan 2002 01:18:33 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Marko Rauhamaa <marko@pacujo.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ routing conflict
Message-ID: <20020124001831.GO29388@arthur.ubicom.tudelft.nl>
In-Reply-To: <m3hepd1ggp.fsf@lumo.pacujo.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hepd1ggp.fsf@lumo.pacujo.nu>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 02:58:46AM -0800, Marko Rauhamaa wrote:
> A google search revealed
> (http://www.cs.helsinki.fi/linux/linux-kernel/2001-44/1775.html)
> that you have recently had similar trouble as I have with PCI
> interrupts. Have you found a resolution to the trouble?
> 
> My new laptop is mostly working, but I can't get my sound card to
> produce a sound. I'm suspecting that the sound driver is not receiving
> interrupts. I can hear the clicking when the driver is loaded -- and I
> have used aumix to set the volume. Both ALSA and OSS (commercial) fail
> the same way.

When using ALSA, be sure to *unmute* the channels with alsamixer (aumix
won't do).


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
