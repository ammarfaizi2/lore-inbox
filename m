Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAINwO>; Tue, 9 Jan 2001 08:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRAINwE>; Tue, 9 Jan 2001 08:52:04 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:3603 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129584AbRAINwB>;
	Tue, 9 Jan 2001 08:52:01 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101091116.f09BGN7281436@saturn.cs.uml.edu>
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
To: shane@agendacomputing.com
Date: Tue, 9 Jan 2001 06:16:23 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010813171211.02165@www.easysolutions.net> from "Shane Nay" at Jan 08, 2001 01:17:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Nay writes:

> but the bits are useless in the "normal interpretation" of it,
...
> But then you pull out the write bits,

If you need to steal a bit, grab one that won't hurt.
Take the owner's read bit. (owner may read own files)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
