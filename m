Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbTCYT41>; Tue, 25 Mar 2003 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbTCYT41>; Tue, 25 Mar 2003 14:56:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:45751 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263269AbTCYT4Z>; Tue, 25 Mar 2003 14:56:25 -0500
Date: Tue, 25 Mar 2003 11:57:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 502] New: Broken cursor when using neofb
Message-ID: <1352210000.1048622262@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=502

           Summary: Broken cursor when using neofb
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jochen@jochen.org


Distribution: Debian sarge
Hardware Environment: IBM Thinkpad 600

Problem Description:

I use neofb, the boot messages are:
Mar 25 20:04:58 gswi1164 kernel: neofb: mapped io at c680d000
Mar 25 20:04:58 gswi1164 kernel: Autodetected internal display
Mar 25 20:04:58 gswi1164 kernel: Panel is a 1024x768 color TFT display
Mar 25 20:04:58 gswi1164 kernel: neofb: mapped framebuffer at c6a0e000
Mar 25 20:04:58 gswi1164 kernel: neofb v0.4.1: 2048kB VRAM, using 1024x768, 48.361kHz, 60Hz
Mar 25 20:04:58 gswi1164 kernel: fb0: MagicGraph 128XD frame buffer device
Mar 25 20:04:58 gswi1164 kernel: Console: switching to colour frame buffer device 128x48

On a vc the line cursor looks like
****** ** ********
instead of
****************** (the normally continous line is broken).
Emacs uses a block cursor that is broken similar, the block
is broken by two vertical bars.

