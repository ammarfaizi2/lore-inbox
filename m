Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265147AbRFZXEf>; Tue, 26 Jun 2001 19:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbRFZXEZ>; Tue, 26 Jun 2001 19:04:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25604 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265147AbRFZXEL>;
	Tue, 26 Jun 2001 19:04:11 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106262304.f5QN410198287@saturn.cs.uml.edu>
Subject: Re: EXT2 Filesystem permissions (bug)?
To: ken@canit.se (Kenneth Johansson)
Date: Tue, 26 Jun 2001 19:04:01 -0400 (EDT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3B390B48.D444B7C5@canit.se> from "Kenneth Johansson" at Jun 27, 2001 12:23:04 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Johansson writes:

> Do linux even support the sticky bit (t) I can't see a reason
> to use it, why would I want the file to be stored in the swap ?? 

It is not currently supported. Swapping out executables would
be very nice when using an NFS or CD-ROM filesystem, because
swap space is much faster.

> Also I think S (setuid but no execute bit) have something to
> do with file locking but I'am not shure exactly how it works. 

Yeah, if you mount with mandatory locking enabled it does stuff.
It's a UNIX feature.
