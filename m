Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279949AbRKVQJ3>; Thu, 22 Nov 2001 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279922AbRKVQJK>; Thu, 22 Nov 2001 11:09:10 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:60863 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279949AbRKVQI7>; Thu, 22 Nov 2001 11:08:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 16:08:57 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk> <3BFD210F.58495F37@starband.net>
In-Reply-To: <3BFD210F.58495F37@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166wPI-0005yT-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 4:00 pm, war wrote:
> Incorrect, my point is I have enough ram where I am not going to run out
> for the things I do.

There's more to it than "not run out". You have some fixed amount of RAM; if 
the VM is working properly, adding swap will IMPROVE performance, because 
that fixed amount of RAM is used more efficiently.

Obviously, there are cases where removing swap breaks the system entirely, 
but even in other cases, adding swap should *never* degrade performance. (In 
theory, anyway; in practice, it still needs tuning...)

> Using swap simply slows the system down!

In which case, the VM isn't working properly; it SHOULD page out infrequently 
used data to make more room for caching frequently used files.


James.
