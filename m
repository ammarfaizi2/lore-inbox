Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273662AbRIQT36>; Mon, 17 Sep 2001 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbRIQT3j>; Mon, 17 Sep 2001 15:29:39 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:9006 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S273567AbRIQT3U>;
	Mon, 17 Sep 2001 15:29:20 -0400
Date: Mon, 17 Sep 2001 21:29:48 +0200
To: linux-kernel@vger.kernel.org
Subject: ACPI and SCSI.
Message-ID: <20010917212948.A559@Saturn.SirVersCastle.home>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz> <3BA0D2BA.8B972B51@gmx.de> <20010913215617.E6820@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010913215617.E6820@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.22i
From: SirVer@gmx.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

just a short question (probably a still unknown bug, I didn't find
anything about this): 
 My Box: a AdvanSys SCSI Low Cost Controller
         a TEAC CDR 55S CD-Burner connected to it
			a new motherboard (Asus) with ACPI, without APM support

now, when i enable ACPI Processor support (nothing else) and i try to
mount a CD, the computer crashes sometimes, but if it doesn't crash on
mounting, it crashes later while accessing the CD. The Display goes
black and the computer doesn't make a move anymore. The software power
switch doesn't work any longer. 
I guess, that this is a bug in the kernel, for the CD works when i
disable the ACPI support and for i never had any problems under *BSD.
But I wasn't able to track the problem down in the source. 
Anyone any ideas?

Thanks
Holger
