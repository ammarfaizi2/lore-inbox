Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278842AbRKDUqS>; Sun, 4 Nov 2001 15:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278837AbRKDUqG>; Sun, 4 Nov 2001 15:46:06 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6927 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278832AbRKDUps>;
	Sun, 4 Nov 2001 15:45:48 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111042045.fA4Kjlo118464@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
To: spacewalker@altern.org (SpaceWalker)
Date: Sun, 4 Nov 2001 15:45:46 -0500 (EST)
Cc: linux-kernel@vger.kernel.org,
        unlisted-recipients:;;;@altern.org; (no To-header on input)
In-Reply-To: <3BE580E4.F17AF70C@altern.org> from "SpaceWalker" at Nov 04, 2001 06:54:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SpaceWalker writes:

> A good reason could be that a simple ps -aux uses hundreds of system
> calls to get the list of all the processes ...

First of all, "ps -aux" isn't correct usage. It is accepted only
as long as you don't have a username "x". Try "ps aux" instead.
(good versions of ps will print a warning -- use Debian)

Second of all, if you want a really fast ps, look here:
http://lwn.net/2000/0420/a/atomicps.html
