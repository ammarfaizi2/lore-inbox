Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135775AbREICNp>; Tue, 8 May 2001 22:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135789AbREICNf>; Tue, 8 May 2001 22:13:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24246 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135775AbREICNS>;
	Tue, 8 May 2001 22:13:18 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.42935.213398.64003@pizda.ninka.net>
Date: Tue, 8 May 2001 19:13:11 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105082036440.11628-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.31.0105081635530.3618-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0105082036440.11628-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > Ok, this patch implements thet thing and also changes ext2+swap+shm
 > writepage operations (so I could test the thing).
 > 
 > The performance is better with the patch on my restricted swapping tests.

Nice.  Now the only bit left is moving the referenced bit
checking and/or state into writepage as well.  This is still
part of the plan right?

Later,
David S. Miller
davem@redhat.com
