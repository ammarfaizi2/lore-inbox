Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312344AbSDCTLY>; Wed, 3 Apr 2002 14:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312345AbSDCTLK>; Wed, 3 Apr 2002 14:11:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41225 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312344AbSDCTKm>; Wed, 3 Apr 2002 14:10:42 -0500
Date: Wed, 3 Apr 2002 11:10:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204031947210.1163-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, you're all wrong, bthththt...

Removing the .._GPL() is in this case correct, but not for any of the 
reasons mentioned, but simply because even Ingo agreed that it shouldn't 
be _GPL since it's explicitly meant for drivers that shouldn't have any 
knowledge whatsoever about the VM internals. GPL or not.

The fact that the code was back-ported from 2.5.x and that the _GPL still 
is there too is just a mistake, partly because I've not gotten any updates 
from Ingo..

		Linus

