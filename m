Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQKLWrt>; Sun, 12 Nov 2000 17:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQKLWrk>; Sun, 12 Nov 2000 17:47:40 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:62735 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131016AbQKLWrb>; Sun, 12 Nov 2000 17:47:31 -0500
Date: Sun, 12 Nov 2000 23:31:45 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
Message-ID: <20001112233144.L4824@arthur.ubicom.tudelft.nl>
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>; from tytso@mit.edu on Sun, Nov 12, 2000 at 02:39:09PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 02:39:09PM -0500, tytso@mit.edu wrote:
>      * USB: system hang with USB audio driver {CRITICAL} (David
>        Woodhouse, Randy Dunlap, Narayan Desai) (Fixed with usb-uhci;
>        uhci-alt is unknown -- randy dunlap)

I can still hang the system with XMMS (1.0.1) using real-time priority.
The system doesn't die, but it is completely unresponsive. There is no
sound, but after the MP3 file is played, the system works again. I can
reproduce this behaviour with usb-uhci and uhci-alt on 2.4.0-test10.
I haven't test test11-pre3 yet, but the changes don't look too big that
the "bug" has been fixed.

BTW, I don't think this is a critical bug.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
