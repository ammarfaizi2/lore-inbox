Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130508AbRAJAVe>; Tue, 9 Jan 2001 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131888AbRAJAVY>; Tue, 9 Jan 2001 19:21:24 -0500
Received: from 108-VALL-X11.libre.retevision.es ([62.83.209.108]:384 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S131765AbRAJAVN>;
	Tue, 9 Jan 2001 19:21:13 -0500
Date: Tue, 9 Jan 2001 17:17:45 +0100
From: Ragnar Hojland Espinosa <ragnar@fuckmpaas.com>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Message-ID: <20010109171745.A3612@lightside.2y.net>
In-Reply-To: <3A5A42F5.648BE730@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A5A42F5.648BE730@goingware.com>; from Michael D. Crawford on Mon, Jan 08, 2001 at 10:45:09PM +0000
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 10:45:09PM +0000, Michael D. Crawford wrote:
> glxinfo says dri is not available if I remove the library as I did.  So I
> rebuilt Mesa and reinstalled it.  The full output of glxinfo on my machine
> follows.  Note that it says "direct rendering: Yes" but the version strings
> don't match.  Does that indicate the problem?
> 

FWIW, this works:

server glx vendor string: SGI
server glx version string: 1.2
client glx vendor string: SGI
client glx version string: 1.2
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Voodoo3 20001101
OpenGL version string: 1.2 Mesa 3.4

> server glx vendor string: Brian Paul
> server glx version string: 1.3 Mesa 3.4
> client glx vendor string: Brian Paul
> client glx version string: 1.2 Mesa 3.4
> OpenGL vendor string: Brian Paul
> OpenGL renderer string: Mesa X11
> OpenGL version string: 1.2 Mesa 3.4

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
