Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTFYOsB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTFYOsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:48:01 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:36775
	"EHLO jumper") by vger.kernel.org with ESMTP id S264312AbTFYOr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:47:59 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5 and neomagic framebuffer problem
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Wed, 25 Jun 2003 18:03:19 +0300
Message-ID: <87n0g6ryh4.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 With 2.5 and neomagic framebuffer on my thinkpad 570e, if
 I do something that outputs a lot of text to the screen
 (dmesg for example), I get what could be called as 'colourful
 static' for either full or lower one third of the screen. 
 Switching to another vt and back restores the normal screen.
 With 2.4 I cannot reproduce this.

 Not sure if it's related, but while editing with any editor,
 sometimes the typed in text comes out on to the line above
 the one that is being edited, two characters ahead. Again,
 this does not happen with 2.4 kernels.

 Driver is compiled into the kernel and output for 2.4.22-pre:

 neofb: mapped io at cc800000
 Panel is a 1024x768 color TFT display
 neofb: mapped framebuffer at cca01000
 neofb v0.3.2: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
 Console: switching to colour frame buffer device 128x48
 fb0: MagicGraph 256AV frame buffer device
 
 and 2.5.73:

 neofb: mapped io at cc80b000
 Autodetected internal display
 Panel is a 1024x768 color TFT display
 neofb: mapped framebuffer at cca0c000
 neofb v0.4.1: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
 fb0: MagicGraph 256AV frame buffer device
 Console: switching to colour frame buffer device 128x48

 Any ideas?

                        --j
