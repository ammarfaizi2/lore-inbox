Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbQKVBlF>; Tue, 21 Nov 2000 20:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132071AbQKVBky>; Tue, 21 Nov 2000 20:40:54 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:48141 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130022AbQKVBkn>;
	Tue, 21 Nov 2000 20:40:43 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011220110.eAM1Ach414423@saturn.cs.uml.edu>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
To: dhinds@lahmed.stanford.edu (David Hinds)
Date: Tue, 21 Nov 2000 20:10:38 -0500 (EST)
Cc: tori@tellus.mine.nu (Tobias Ringstrom),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20001121160443.B18150@lahmed.stanford.edu> from "David Hinds" at Nov 21, 2000 04:04:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The subject says it all. Is there any particular (technical) reason
>> why I must have both the generic pcmcia code and the controller
>> support built-in, or build all of them as modules?
>
> Is there a technical reason for this?  Not that I know of; but then I
> also cannot think of a good reason for wanting, say, the generic code
> built in but the controller support as modules.  I do see reasonable
> arguments for all-builtin or all-modules.

Hmmm, I'm not the only one who doesn't like modules depending
on other modules. I suppose this is part paranoia about extra
complexity leading to problems, and part desire to avoid the
module overhead for common code that will most likely get used.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
