Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135369AbRA0Ukg>; Sat, 27 Jan 2001 15:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135464AbRA0Uk1>; Sat, 27 Jan 2001 15:40:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:15114 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135369AbRA0UkM>;
	Sat, 27 Jan 2001 15:40:12 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101272040.f0RKe2O372406@saturn.cs.uml.edu>
Subject: Re: the remount problem [2.4.0] kind of solved [patch]
To: wichert@valinux.com (Wichert Akkerman)
Date: Sat, 27 Jan 2001 15:40:01 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
In-Reply-To: <20010126162129.J5539@cistron.nl> from "Wichert Akkerman" at Jan 26, 2001 04:21:29 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman writes:
> Previously Goswin Brederlow wrote:

>> Maybe the kernel coud swap in the deleted libraries and keep it in
>> memory or real swap from then on instead of blocking the fs.
>
> No, you have no idea how large the file might grow and you need to
> keep that data somewhere.

Grow? It makes little difference, since you can run out of filesystem
space too.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
