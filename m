Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQKMX6e>; Mon, 13 Nov 2000 18:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbQKMX6Y>; Mon, 13 Nov 2000 18:58:24 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60165 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129481AbQKMX6O>; Mon, 13 Nov 2000 18:58:14 -0500
Date: Tue, 14 Nov 2000 00:19:20 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Roger Larsson <roger@norran.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
Message-ID: <20001114001918.C12931@arthur.ubicom.tudelft.nl>
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org> <20001112233144.L4824@arthur.ubicom.tudelft.nl> <00111323580000.01856@dox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00111323580000.01856@dox>; from roger@norran.net on Mon, Nov 13, 2000 at 11:58:00PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 11:58:00PM +0100, Roger Larsson wrote:
> On Sunday 12 November 2000 23:31, Erik Mouw wrote:
> > I can still hang the system with XMMS (1.0.1) using real-time priority.
> > The system doesn't die, but it is completely unresponsive. There is no
> > sound, but after the MP3 file is played, the system works again. I can
> > reproduce this behaviour with usb-uhci and uhci-alt on 2.4.0-test10.
> > I haven't test test11-pre3 yet, but the changes don't look too big that
> > the "bug" has been fixed.
> 
> Does it use non blocking IO?
> In such case you might have created an infinite loop at high priority
> resulting in a busylock of all other processes.

Possible, I didn't look at the source. It would explain the behaviour,
but why isn't there any sound?


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
