Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLEFBr>; Tue, 5 Dec 2000 00:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQLEFBi>; Tue, 5 Dec 2000 00:01:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51084 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129370AbQLEFBX>;
	Tue, 5 Dec 2000 00:01:23 -0500
Date: Mon, 4 Dec 2000 23:25:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012041955000.860-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012042320280.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Linus Torvalds wrote:

> So? Why wouldn't clear_inode() get rid of it?

It will. Mea culpa. However, other reasons for taking the bh of freed
block from the list still stand. IOW, consider that part as an
optimization.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
