Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRBZWCh>; Mon, 26 Feb 2001 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbRBZWC2>; Mon, 26 Feb 2001 17:02:28 -0500
Received: from p3EE3CBF4.dip.t-dialin.net ([62.227.203.244]:59909 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129164AbRBZWCW>; Mon, 26 Feb 2001 17:02:22 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18: difficulties with Ensoniq 5880 (es1371) rev 0x03?
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Date: 26 Feb 2001 21:26:15 +0100
Message-ID: <m33dd1yyvs.fsf@emma1.emma.line.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already asked this on the linux-sound mailing list almost 10 days ago,
but got no response. So here it is again, header cut down to essentials:

-----
Date:	Sat, 17 Feb 2001 12:04:32 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-sound@vger.kernel.org
Subject: 2.2.18: difficulties with Ensoniq 5880 (es1371) rev 0x03?
Message-ID: <20010217120432.A3823@emma1.emma.line.org>

Hi,

I'm having strange happenings with various Gigabyte boards and Linux
2.2.18 here. Short story: 7ZXR with Ens 5880 rev 02 has sound, 7XR with
Ens 5880 rev 03 does not have sound.

I bought a Gigabyte 7ZXR in December which has a 

00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Giga-byte Technology: Unknown device a000
        Flags: bus master, slow devsel, latency 64, IRQ 12
        I/O ports at c800
        Capabilities: [dc] Power Management version 1
(this one shares the IRQ with a 53c875 on a Tekram DC390U)

 es1371: stereo enhancement: SigmaTel SS3D
 es1371: version v0.22 time 13:30:09 Jan 24 2001
 es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
 es1371: found es1371 rev 2 at io 0xc800 irq 12
 es1371: features: joystick 0x200
 es1371: codec vendor   v (0x838476) revision 8 (0x08)
 es1371: codec features 18bit DAC 18bit ADC
 es1371: stereo enhancement: SigmaTel SS3D

Now, at University, we bought some 7ZX in February which have a (mind
the revision)

00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 03)
        Subsystem: Giga-byte Technology: Unknown device a000
        Flags: bus master, slow devsel, latency 64, IRQ 10
        I/O ports at d000
        Capabilities: [dc] Power Management version 2
(this one does not share its IRQ)

 es1371: version v0.22 time 21:01:40 Feb  5 2001
 es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x03
 es1371: found es1371 rev 3 at io 0xd000 irq 10
 es1371: features: joystick 0x0
 es1371: codec vendor     (0x000000) revision 0 (0x00)
 es1371: codec features none
 es1371: stereo enhancement: no 3D stereo enhancement

What's going on with the new 7ZX boards with rev 0x03? They don't show a
codec, and don't make any sound. Is this a known problem? Is there a
solution?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-sound" in
the body of a message to majordomo@vger.kernel.org
