Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272710AbRIRI41>; Tue, 18 Sep 2001 04:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272926AbRIRI4Q>; Tue, 18 Sep 2001 04:56:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32501 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272912AbRIRI4G>;
	Tue, 18 Sep 2001 04:56:06 -0400
Date: Tue, 18 Sep 2001 04:56:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Alex Stewart <alex@foogod.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
In-Reply-To: <20010918023942.A28179@emma1.emma.line.org>
Message-ID: <Pine.GSO.4.21.0109180453270.25323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Matthias Andree wrote:

> Well, you cannot tell your local power plant "you must not fail this
> very moment" either. Of course, data will be lost when a process is
> killed from "D" state, but if the admin can tell the data will be lost
> either way, ... 

Gaack... Just how do you kill a process that holds a bunch of semaphores
and got blocked on attempt to take one more?  It's not about lost data,
it's about completely screwed kernel.

