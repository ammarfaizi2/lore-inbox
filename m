Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbRESTiS>; Sat, 19 May 2001 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbRESTiH>; Sat, 19 May 2001 15:38:07 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261983AbRESThy>; Sat, 19 May 2001 15:37:54 -0400
Date: Sat, 19 May 2001 12:37:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brad Boyer <flar@pants.nu>
cc: Aaron Lehmann <aaronl@vitelus.com>, Andries.Brouwer@cwi.nl,
        andrewm@uow.edu.au, bcrl@redhat.com, clausen@gnu.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
 inuserspace
In-Reply-To: <20010519195010.4C11A2B54A@marcus.pants.nu>
Message-ID: <Pine.LNX.4.21.0105191236150.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Brad Boyer wrote:
> 
> If I understand the status of stuff correctly, I think this would make it
> a lot more painful to admin if it became a requirement to use initrd on
> everything just to be able to boot.

Don't get too hung up on initrd. Symbolic links really _are_ workable ways
to basically cache the information across boots, and the real problems are
elsewhere.

		Linus

