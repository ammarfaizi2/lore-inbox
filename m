Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129687AbQKQQHu>; Fri, 17 Nov 2000 11:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbQKQQHk>; Fri, 17 Nov 2000 11:07:40 -0500
Received: from hera.cwi.nl ([192.16.191.1]:9384 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129687AbQKQQHY>;
	Fri, 17 Nov 2000 11:07:24 -0500
Date: Fri, 17 Nov 2000 16:37:16 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: "SubmittingPatches" text
Message-ID: <20001117163716.A29847@veritas.com>
In-Reply-To: <200011162132.PAA01944@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.10.10011170927000.20243-100000@chaos.thphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011170927000.20243-100000@chaos.thphy.uni-duesseldorf.de>; from kai@thphy.uni-duesseldorf.de on Fri, Nov 17, 2000 at 09:30:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 09:30:13AM +0100, Kai Germaschewski wrote:

> One question comes to my mind: Are patches supposed to be applied with
> patch -p0 or patch -p1? 

Suppose the kernel tree is in /kernpath, starting with /kernpath/linux.
Linus' patches can be applied by (cd /kernpath; patch -p0 -s < patch)
while Alan's patches only work if you do
(cd /kernpath/linux; patch -p1 -s < ../patch)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
