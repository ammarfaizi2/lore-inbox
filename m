Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261247AbRETBDa>; Sat, 19 May 2001 21:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261251AbRETBDU>; Sat, 19 May 2001 21:03:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5549 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261238AbRETBDQ>;
	Sat, 19 May 2001 21:03:16 -0400
Message-ID: <3B0717CE.57613D4A@mandrakesoft.com>
Date: Sat, 19 May 2001 21:03:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105191728140.15174-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a dumb question, and I apologize if I am questioning computer
science dogma...

Why are LVM and EVMS(competing LVM project) needed at all?

Surely the same can be accomplished with
* md
* snapshot blkdev (attached in previous e-mail)
* giving partitions and blkdevs the ability to grow and shrink
* giving filesystems the ability to grow and shrink

On-line optimization (defrag, etc) shouldn't be hard once you have the
ability to move blocks and files around, which would come with the
ability to grow and shrink blkdevs and fs's.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
