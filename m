Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270318AbRHHEu5>; Wed, 8 Aug 2001 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270317AbRHHEur>; Wed, 8 Aug 2001 00:50:47 -0400
Received: from prv-tm19.provo.novell.com ([192.108.102.149]:43912 "EHLO
	MyRealbox.com") by vger.kernel.org with ESMTP id <S270316AbRHHEuf>;
	Wed, 8 Aug 2001 00:50:35 -0400
Subject: USB Wacom PenPartner and HID + mousedev
Reply-To: spinor<REMOVE_SPAM_BLOCK@zip.com.au>@myrealbox.com
From: Spin <spinor@MyRealBox.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 08 Aug 2001 04:50:45 +0000
X-Mailer: NIMS ModWeb Module
MIME-Version: 1.0
Message-ID: <997246245.3abb5ff9spinor@MyRealBox.com>
Content-Type: multipart/mixed;
	boundary="------=_ModWebBOUNDARY_3abb5ff9_997246245"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--------=_ModWebBOUNDARY_3abb5ff9_997246245
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm using a USB PenPartner and having some trouble with the pointer freezin=
g before it reaches the edge of the screen.  If I use my regular mouse to=
 continue moving the pointer, I can "teach" the stylus the boundaries of =
my screen, but unfortunately it soon forgets them, forcing me to start us=
ing my mouse again  :)

My set up is 2.4.5 kernel + XFree 4.0.3.  I'm using the HID driver since ke=
rnel documentation claims the PenPartner is a true HID device and hence s=
hould use the HID (unlike Intuos and Graphire, which need the wacom kerne=
l module).  I then use the mousedev module to create a PS/2 interface to =
talk to the standard mouse driver under XFree.  I compiled the mousedev d=
river with the screen resolution option set to match the size of my 1600x=
1200 display.

Has anyone else had this problem too?  Any suggestions for how to fix this =
problem or where to look in the source code for possible trouble are welc=
ome, since I've exasperated myself at this point trying to get this table=
t working well enough to do a little drawing ... and the wacom mailing li=
st for the linux driver has not been of much help since most of the peopl=
e there are trying to configure the (newer) Graphire and Intuos models.

Many thanks in advance.  If you want to CC: me on any replies, please bewar=
e the <REMOVE_SPAM_BLOCK> in my reply email address.



--------=_ModWebBOUNDARY_3abb5ff9_997246245
Content-Type: application/octet-stream;
	name="Unknown_File_Name"
Content-Transfer-Encoding: BASE64
Content-Disposition: attachment;
	filename="Unknown_File_Name"

DQo=

--------=_ModWebBOUNDARY_3abb5ff9_997246245--
