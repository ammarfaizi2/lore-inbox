Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRA2HiU>; Mon, 29 Jan 2001 02:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135706AbRA2HiK>; Mon, 29 Jan 2001 02:38:10 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57031 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132224AbRA2HiA>;
	Mon, 29 Jan 2001 02:38:00 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14965.7321.926528.391631@pizda.ninka.net>
Date: Sun, 28 Jan 2001 23:32:41 -0800 (PST)
To: James Sutherland <jas88@cam.ac.uk>
Cc: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101281642180.16734-100000@green.csi.cam.ac.uk>
In-Reply-To: <951am4$gbf$1@ncc1701.cistron.net>
	<Pine.SOL.4.21.0101281642180.16734-100000@green.csi.cam.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Sutherland writes:
 > Except you can detect and deal with these "PMTU black holes". Just as you
 > should detect and deal with ECN black holes. Maybe an ideal Internet
 > wouldn't have them, but this one does. If you can find an ideal Internet,
 > go code for it: until then, stick with the real one. It's all we've got.

Guess what, Linux works not around PMTU black holes either for the
same exact reason we will not work around ECN.

I'm getting a bit tired of you, and I suppose others are as
well.  You are being nothing but a pompous ass.

Anyways, let me quote a comment from the Linux source code where
we would have done PMTU black hole detection:

			/* NOTE. draft-ietf-tcpimpl-pmtud-01.txt requires pmtu black
			   hole detection. :-(

			   It is place to make it. It is not made. I do not want
			   to make it. It is disguisting. It does not work in any
			   case. Let me to cite the same draft, which requires for
			   us to implement this:

   "The one security concern raised by this memo is that ICMP black holes
   are often caused by over-zealous security administrators who block
   all ICMP messages.  It is vitally important that those who design and
   deploy security systems understand the impact of strict filtering on
   upper-layer protocols.  The safest web site in the world is worthless
   if most TCP implementations cannot transfer data from it.  It would
   be far nicer to have all of the black holes fixed rather than fixing
   all of the TCP implementations."

                           Golden words :-).
		   */

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
