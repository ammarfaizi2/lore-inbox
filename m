Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbRLFG7W>; Thu, 6 Dec 2001 01:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285026AbRLFG7N>; Thu, 6 Dec 2001 01:59:13 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:4881 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S285022AbRLFG7E>;
	Thu, 6 Dec 2001 01:59:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112060658.fB66wtp351314@saturn.cs.uml.edu>
Subject: Re: small feature request
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 6 Dec 2001 01:58:55 -0500 (EST)
Cc: reese@isn.net (Garst R. Reese),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <11596.1007177140@ocs3.intra.ocs.com.au> from "Keith Owens" at Dec 01, 2001 02:25:40 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> "Garst R. Reese" <reese@isn.net> wrote:

>> Would it possible to put a header on System.map indicating the kernel
>> version?
>> Sometimes my little brain forgets what kernel System.old is for.
>
> It is on my list for kbuild 2.5, once I start on the new design for

Nooooo!!!!!

Don't break stuff by adding headers. There is already a version
in the file. It's in decimal, which sucks, but this will find it:

grep ' Version_' System.map

Adding a random 128-bit ID might be nice, as long as it's done
in the same sort of way and is available via /proc. Something
like this would do:  kern_128_id_UkZd1JLdOvAsALfFEL1UI
