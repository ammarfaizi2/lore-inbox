Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271934AbTGYGxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271935AbTGYGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:53:19 -0400
Received: from dsl093-170-248.sfo2.dsl.speakeasy.net ([66.93.170.248]:55544
	"HELO parts-unknown.org") by vger.kernel.org with SMTP
	id S271934AbTGYGxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:53:03 -0400
Date: Fri, 25 Jul 2003 00:08:06 -0700
From: David Benfell <benfell@greybeard95a.com>
To: linux-kernel@vger.kernel.org
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030725070806.GB15819@parts-unknown.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <bXg8.4Wg.1@gated-at.bofh.it> <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org> <20030724212416.GA18141@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20030724212416.GA18141@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
X-stardate: [-29]0641.40
X-moon: The Moon is Waning Crescent (16% of Full)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: multipart/mixed; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

First someone pointed me at the driver available through

http://w1.894.telia.com/~u89404340/touchpad/index.html

I hadn't known about this, but I implemented it.  It does not work
for me under either the 2.6.0-test1-ac2 kernel or the kernel I was
using before (2.4.21-pre6).

Output from the startx is:

XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.0-test1-ac1 i686 [ELF]=20
Build Date: 23 July 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(=3D=3D) Log file: "/var/log/XFree86.0.log", Time: Wed Jul 23 08:01:03 2003
(=3D=3D) Using config file: "/etc/X11/XF86Config"

    [10e] 320 x 200, 70Hz
    [111] 640 x 480, 60Hz, 72Hz, 75Hz, 85Hz
    [114] 800 x 600, 60Hz, 72Hz, 75Hz, 85Hz
    [117] 1024 x 768, 60Hz, 70Hz, 75Hz, 85Hz
    [11a] 1280 x 1024, 60Hz, 75Hz
    [11d] 640 x 400, 70Hz
    [122] 1600 x 1200, 60Hz
    [133] 320 x 240, 72Hz
    [13c] 1400 x 1050, 60Hz, 75Hz
    [143] 400 x 300, 72Hz
    [153] 512 x 384, 70Hz
    [173] 720 x 480, 75Hz
    [17e] 720 x 576, 75Hz
auto-dev: Found Synaptics in /proc/bus/input/devices
auto-dev: Found its handler entry
auto-dev: cannot find the event-device in the handlers-entry for the Synapt=
ics touchpad hardware. Falling back to psaux protocol and the Device Option=
 from XF86Config.
Query no Synaptics: 6003C8
(EE) Mouse[1] no synaptics touchpad detected and no repeater device
(EE) Mouse[1] Unable to query/initialize Synaptics hardware.
(EE) PreInit failed for input device "Mouse[1]"
No core pointer

Fatal server error:
failed to initialize core devices

When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.

XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"=0D
      after 0 requests (0 known processed) with 0 events remaining.=0D

On Thu, 24 Jul 2003 23:24:16 +0200, Petr Vandrovec wrote:
> On Thu, Jul 24, 2003 at 10:27:51PM +0200, Michael Schierl wrote:
> > David Benfell <benfell@greybeard95a.com> wrote:
> >=20
> > However, giving 'psmouse_noext' as kernel param helped for me to make
> > the touchpad work (using /dev/input/mice (protocol autops2) as source
> > for gpm and gpm repeater as source for x, as I did in 2.4.x kernels).
> >=20
No joy here, either:

[Using /dev/input/mouse as the input device]

XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.0-test1-ac1 i686 [ELF]=20
Build Date: 23 July 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(=3D=3D) Log file: "/var/log/XFree86.0.log", Time: Wed Jul 23 09:25:40 2003
(=3D=3D) Using config file: "/etc/X11/XF86Config"

    [10e] 320 x 200, 70Hz
    [111] 640 x 480, 60Hz, 72Hz, 75Hz, 85Hz
    [114] 800 x 600, 60Hz, 72Hz, 75Hz, 85Hz
    [117] 1024 x 768, 60Hz, 70Hz, 75Hz, 85Hz
    [11a] 1280 x 1024, 60Hz, 75Hz
    [11d] 640 x 400, 70Hz
    [122] 1600 x 1200, 60Hz
    [133] 320 x 240, 72Hz
    [13c] 1400 x 1050, 60Hz, 75Hz
    [143] 400 x 300, 72Hz
    [153] 512 x 384, 70Hz
    [173] 720 x 480, 75Hz
    [17e] 720 x 576, 75Hz
auto-dev: Could not find N: Name=3D"Synaptics Synaptics TouchPad" and its h=
andler entry H: Handlers=3D in /proc/bus/input/devices. So we are unable to=
 auto-determine the synaptics touchpad device, falling back to psaux protoc=
ol and the Device Option.
(EE) xf86OpenSerial: Cannot open device /dev/input/mouse
	No such file or directory.
Synaptics driver unable to open device
(EE) PreInit failed for input device "Mouse[1]"
No core pointer

Fatal server error:
failed to initialize core devices

When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.

XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"=0D
      after 0 requests (0 known processed) with 0 events remaining.=0D

[Using /dev/psaux as the input device]

XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.0-test1-ac1 i686 [ELF]=20
Build Date: 23 July 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(=3D=3D) Log file: "/var/log/XFree86.0.log", Time: Wed Jul 23 09:22:03 2003
(=3D=3D) Using config file: "/etc/X11/XF86Config"
    [10e] 320 x 200, 70Hz
    [111] 640 x 480, 60Hz, 72Hz, 75Hz, 85Hz
    [114] 800 x 600, 60Hz, 72Hz, 75Hz, 85Hz
    [117] 1024 x 768, 60Hz, 70Hz, 75Hz, 85Hz
    [11a] 1280 x 1024, 60Hz, 75Hz
    [11d] 640 x 400, 70Hz
    [122] 1600 x 1200, 60Hz
    [133] 320 x 240, 72Hz
    [13c] 1400 x 1050, 60Hz, 75Hz
    [143] 400 x 300, 72Hz
    [153] 512 x 384, 70Hz
    [173] 720 x 480, 75Hz
    [17e] 720 x 576, 75Hz
auto-dev: Could not find N: Name=3D"Synaptics Synaptics TouchPad" and its h=
andler entry H: Handlers=3D in /proc/bus/input/devices. So we are unable to=
 auto-determine the synaptics touchpad device, falling back to psaux protoc=
ol and the Device Option.
Query no Synaptics: 6003C8
(EE) Mouse[1] no synaptics touchpad detected and no repeater device
(EE) Mouse[1] Unable to query/initialize Synaptics hardware.
(EE) PreInit failed for input device "Mouse[1]"
No core pointer

Fatal server error:
failed to initialize core devices

When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.

XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"=0D
      after 0 requests (0 known processed) with 0 events remaining.=0D

I've attached my XF86Config, which includes commented out remnants of
things I've tried.

Thanks!
--=20
David Benfell
benfell@parts-unknown.org

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hp-zt1180-XF86Config
Content-Transfer-Encoding: quoted-printable

# /.../
# SaX generated XFree86 config file
# Created on: 2002-04-05.
#
# Version: 4.3
# Contact: Marcus Schaefer <sax@suse.de>, 2001
#
# Automatically generated by [ISaX] (4.3)
# PLEASE DO NOT EDIT THIS FILE!
#
Section "Files"
  FontPath     "/usr/X11R6/lib/X11/fonts/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/local"
  FontPath     "/usr/X11R6/lib/X11/fonts/misc:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/100dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/Type1"
  FontPath     "/usr/X11R6/lib/X11/fonts/URW"
  FontPath     "/usr/X11R6/lib/X11/fonts/Speedo"
  FontPath     "/usr/X11R6/lib/X11/fonts/PEX"
  FontPath     "/usr/X11R6/lib/X11/fonts/cyrillic"
  FontPath     "/usr/X11R6/lib/X11/fonts/latin2/misc:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/latin2/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/latin2/100dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/latin2/Type1"
  FontPath     "/usr/X11R6/lib/X11/fonts/latin7/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/baekmuk:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/japanese:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/kwintv"
  FontPath     "/usr/X11R6/lib/X11/fonts/truetype"
  FontPath     "/usr/X11R6/lib/X11/fonts/uni"
  FontPath     "/usr/X11R6/lib/X11/fonts/CID"
  FontPath     "/usr/X11R6/lib/X11/fonts/ucs/misc"
  FontPath     "/usr/X11R6/lib/X11/fonts/ucs/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/ucs/100dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/hellas/misc:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/hellas/75dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/hellas/100dpi:unscaled"
  FontPath     "/usr/X11R6/lib/X11/fonts/hellas/Type1"
  FontPath     "/usr/X11R6/lib/X11/fonts/misc/sgi"
  FontPath     "/usr/X11R6/lib/X11/fonts/xtest"
  FontPath     "/usr/local/fonts/ttf"
  ModulePath   "/usr/X11R6/lib/modules"
  RgbPath      "/usr/X11R6/lib/X11/rgb"
EndSection

Section "ServerFlags"
  Option       "AllowMouseOpenFail"
EndSection

Section "Module"
  Load         "dbe"
  Load         "type1"
  Load         "speedo"
  Load         "extmod"
  Load         "freetype"
  Load         "synaptics"
EndSection

Section "InputDevice"
  Driver       "keyboard"
  Identifier   "Keyboard[0]"
  Option       "Protocol" "Standard"
  Option       "XkbKeyCodes" "xfree86"
  Option       "XkbLayout" "us"
  Option       "XkbModel" "pc104"
  Option       "XkbRules" "xfree86"
EndSection

#Section "InputDevice"
  #Driver       "mouse"
  #Identifier   "Mouse[1]"
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::: on the HP ZT1180, you must tell it that it's really two buttons, then =
to fake being 3...=20
#::: or 5 like most wheels
  #Option       "ButtonNumber" "5"
  #Option       "ButtonNumber" "2"
  #Option	"Emulate3Buttons"
  #Option       "ZAxisMapping" "4 5"
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::: it hates gpm though. sorry.
  #Option       "Device" "/dev/psaux"
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  #Option       "Name" "AutoDetected"
  #Option       "Protocol" "imps/2"
  #Option       "Vendor" "AutoDetected"
#EndSection

Section "InputDevice"
  Driver  	"synaptics"
  Identifier  	"Mouse[1]"
  Option 	"Device"  	"/dev/input/mouse"
  #Option 	"Device"  	"/dev/psaux"
  Option	"Protocol"	"auto-dev"
  Option	"LeftEdge"      "1900"
  Option	"RightEdge"     "5400"
  Option	"TopEdge"       "3900"
  Option	"BottomEdge"    "1800"
  Option	"FingerLow"	"25"
  Option	"FingerHigh"	"30"
  Option	"MaxTapTime"	"180"
  Option	"MaxTapMove"	"220"
  Option	"VertScrollDelta" "100"
  Option	"MinSpeed"	"0.02"
  Option	"MaxSpeed"	"0.18"
  Option	"AccelFactor" "0.0010"
#  Option	"Repeater"	"/dev/ps2mouse"
#  Option	"SHMConfig"	"on"
EndSection


Section "Monitor"
  HorizSync    30-90
  Identifier   "Monitor[0]"
  ModelName    "AutoDetected"
  VendorName   "AutoDetected"
  VertRefresh  56-83
  UseModes     "Modes[0]"
EndSection

Section "Modes"
  Identifier   "Modes[0]"
  Modeline 	"1400x1050" 158.26 1400 1416 1704 1944 1050 1050 1063 1097
EndSection

Section "Screen"
  DefaultDepth 16
  SubSection "Display"
    Depth      16
    Modes      "1400x1050"=20
  EndSubSection
  Device       "Device[0]"
  Identifier   "Screen[0]"
  Monitor      "Monitor[0]"
EndSection

Section "Device"
  BoardName    "AutoDetected"
  Driver       "savage"
  Identifier   "Device[0]"
  Option       "dpms"
  VendorName   "AutoDetected"
EndSection

Section "ServerLayout"
  Identifier   "Layout[all]"
  InputDevice  "Keyboard[0]" "CoreKeyboard"
  InputDevice  "Mouse[1]" "CorePointer"
  Screen       "Screen[0]"
EndSection

Section "DRI"
    Group      "video"
    Mode       0660
EndSection


--xXmbgvnjoT4axfJE--

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (Darwin)

iQEXAwUBPyDXVHw5zqzgtjVOFAKzmAP/THfmxoC3v3fjAYHi1JXGHMWYtvghpVbn
SacbQXISc7iEcGq5TL0S6BHJoaaiz/zX/QrIS4dC3shWm+sDoEAxB4wfaYY5QWLx
cUswT3Vyjii1t+SO8cvSplN26zZVPORfOTT+/SC1q1HX0L179jFu/ywql0FRMRir
RXeeHR74p6QEAKSaWdf8HcR32l7PppTi/43oPSB+2EcL7K9Pyh6CTLjCWwo1AqMt
v607zFmA9o/dmzOfo+x7xTs1DpQL9hkk8RYzRYsofIOSs0vRzqIVjahfuREW9mam
314M7ED8klgXUAkcKTNQtIkUULt8qmkbMO/4BZmOgK9SU6pH5OdGIvyI
=gyEq
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
