Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129070AbQJ3UdY>; Mon, 30 Oct 2000 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQJ3UdO>; Mon, 30 Oct 2000 15:33:14 -0500
Received: from ns.caldera.de ([212.34.180.1]:12550 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129070AbQJ3UdI>;
	Mon, 30 Oct 2000 15:33:08 -0500
Date: Mon, 30 Oct 2000 21:32:28 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001030213228.A4956@caldera.de>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de> <39FDC447.C5DD7864@mandrakesoft.com> <20001030204403.A19 <39FDD53F.5AC31232@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <39FDD53F.5AC31232@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Oct 30, 2000 at 03:08:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 03:08:31PM -0500, Jeff Garzik wrote:
> Actually, I wonder if its even possible for mmap_kiobuf to support audio
> -- full duplex requires that both record and playback buffer(s),
> theoretically two separate sets of kiobufs, to be presented as one space
> (with playback always presented before record).

kvmaps take kiovecs, which are multiple kiobufs ...

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
