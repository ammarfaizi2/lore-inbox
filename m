Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277493AbRJOMCj>; Mon, 15 Oct 2001 08:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277485AbRJOMCa>; Mon, 15 Oct 2001 08:02:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277483AbRJOMCS>; Mon, 15 Oct 2001 08:02:18 -0400
Subject: Re: [RFC] "Text file busy" when overwriting libraries
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 15 Oct 2001 13:08:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ebiederm@xmission.com (Eric W. Biederman),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110150751540.8707-100000@weyl.math.psu.edu> from "Alexander Viro" at Oct 15, 2001 07:57:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15t6XR-0001xy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone can write it, but what the hell will he do without write access to
> any place that wouldn't be mounted noexec?  Environment can be restricted
> even if you give them shell...

He will type "perl" and interactively issue any damn syscall he likes
subject to the normal permissions rules. Noexec is only useful for a user
given virtually nothing.

ALan


