Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVKYLMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVKYLMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVKYLMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:12:13 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:45640 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751448AbVKYLMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:12:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=qyMUhxdGhaZo5WGsVcbJQTbbxBuN/lkyFvaEqYL2+/HwDqN8LIljH0oEXFJZtbumDwZGT+JTgoIDPXSFB058/lczvV1dvpmMOrCuh86wz/LQOgUz8xkIKNEAVAX/V8G4FRhTKpGhL4zvRGn+b1q3z1pOsWgqDq+V/Vt0Vk16XV0=
Message-ID: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
Date: Fri, 25 Nov 2005 11:12:11 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3437_32612634.1132917131088"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3437_32612634.1132917131088
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm having some strange software/package compile problem under Gentoo
and kernels with 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2. When I
install/update a package via emerge, I got occasional hangs at compile
time. When this happenned, system continues to work. No error
messages, no interruption. Just the compile process hangs. Killing
this hanged process is impossible. Immediately, it becomes Zombie
process. Also, Reboot and poweroff hangs, too. Just hard
reboot/poweroff solves it. I've never had this problem under 2.6.14
and downwards.
My ver_linux is attached.

PS: I found a way to reproduce this; installing/updating "man-pages"
package under Gentoo always hangs.


Regards.

------=_Part_3437_32612634.1132917131088
Content-Type: application/octet-stream; name=ver_linux.out
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ver_linux.out"

Linux hightemple 2.6.14 #1 Fri Oct 28 23:02:31 Local time zone must be set--see zic manu i686 Intel(R) Pentium(R) M processor 1400MHz GenuineIntel GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2-pre7
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.36
pcmcia-cs              3.2.8
quota-tools            3.13.
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   073
Modules Loaded         arc4 pcmcia yenta_socket rsrc_nonstatic pcmcia_core rfcomm l2cap snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ntfs ieee80211_crypt_tkip ieee80211_crypt_ccmp usbhid ieee80211_crypt_wep ipw2100 ieee80211 ieee80211_crypt firmware_class e100 mii bluetooth uhci_hcd ehci_hcd ohci_hcd usb_storage usbcore scsi_mod as_iosched agpgart 

------=_Part_3437_32612634.1132917131088--
