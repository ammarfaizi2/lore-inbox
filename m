Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbRD1E5O>; Sat, 28 Apr 2001 00:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRD1E5F>; Sat, 28 Apr 2001 00:57:05 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:39946 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132732AbRD1E4w>;
	Sat, 28 Apr 2001 00:56:52 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104280455.f3S4tQ8336512@saturn.cs.uml.edu>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 28 Apr 2001 00:55:26 -0400 (EDT)
Cc: vojtech@suse.cz (Vojtech Pavlik), viro@math.psu.edu (Alexander Viro),
        andrea@suse.de (Andrea Arcangeli), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104270951270.2067-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 27, 2001 09:52:19 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The buffer cache is "virtual" in the sense that /dev/hda is a
> completely separate name-space from /dev/hda1, even if there
> is some physical overlap.

So the aliasing problems and elevator algorithm confusion remain?
Is this ever likely to change, and what is with the 1 kB assumptions?
(Hmmm, cruft left over from the 1 kB Minix filesystem blocks?)
