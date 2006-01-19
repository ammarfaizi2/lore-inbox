Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWASToe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWASToe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWASToe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:44:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36869 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161322AbWASToc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:44:32 -0500
Date: Thu, 19 Jan 2006 20:44:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119194432.GX19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de> <1137695945.32195.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137695945.32195.7.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:39:04PM -0500, Lee Revell wrote:
> 
> Are there any other cases like that?  Maybe you could indent the list to
> clearly show the relationship?

Updated list below.

> Lee

cu
Adrian


<--  snip  -->


1. ALSA drivers for the same hardware 

SOUND_AD1889
SOUND_AD1980
SOUND_ALI5455
SOUND_AU1000
SOUND_AWE32_SYNTH
SOUND_CMPCI
SOUND_CS4232
SOUND_CS4281
SOUND_ES1370
SOUND_ES1371
SOUND_ESSSOLO1
SOUND_FORTE
SOUND_FUSION
SOUND_GUS
SOUND_HARMONY
SOUND_MAD16
SOUND_MAESTRO
SOUND_MAESTRO3
SOUND_MAUI
SOUND_OPL3SA1
SOUND_OPL3SA2
SOUND_RME96XX
SOUND_SGALAXY
SOUND_SONICVIBES
SOUND_SSCAPE
SOUND_VIA82CXXX
SOUND_WAVEFRONT
SOUND_YMFPCI


2. ALSA drivers for the same hardware with known problems

SOUND_AD1816
- ALSA #1301 (Kernel OSS emulation stops working after a few seconds
              when used with VoIP softphones)

SOUND_EMU10K1
- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)

SOUND_ICH
- Alan Cox: ALSA driver lacks "support for AC97 wired touchscreens
                               and the like"

SOUND_NM256
- ALSA #328 (snd-nm256 freezes Dell Latitude LS)

SOUND_TRIDENT
- ALSA #1293 (device supported by OSS but not by ALSA)
- maintainer of the OSS driver wants his driver to stay


3. no ALSA drivers for the same hardware

SOUND_ACI_MIXER
SOUND_ADLIB
SOUND_AEDSP16
SOUND_AU1550_AC97
SOUND_BCM_CS4297A
SOUND_HAL2
SOUND_IT8172
SOUND_KAHLUA
SOUND_MSNDCLAS
SOUND_MSNDPIN
SOUND_MSS (also due to SOUND_PSS, SOUND_TRIX and perhaps SOUND_AEDSP16)
SOUND_PAS
SOUND_PSS
SOUND_SB (due to SOUND_KAHLUA, SOUND_PAS and perhaps SOUND_AEDSP16)
SOUND_SH_DAC_AUDIO
SOUND_TRIX
SOUND_VIDC
SOUND_VRC5477
SOUND_VWSND
SOUND_WAVEARTIST

