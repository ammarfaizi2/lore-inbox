Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288756AbSA2FA5>; Tue, 29 Jan 2002 00:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288784AbSA2FAs>; Tue, 29 Jan 2002 00:00:48 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:1675
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288756AbSA2FAj>; Tue, 29 Jan 2002 00:00:39 -0500
Message-Id: <200201290500.g0T50eU32174@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 00:01:36 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com>
In-Reply-To: <a354iv$ai9$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 January 2002 10:23 pm, Linus Torvalds wrote:

> One "patch penguin" scales no better than I do. In fact, I will claim
> that most of them scale a whole lot worse.

Oh, one other thing.  I didn't emphasize the possibility that the patch 
penguin might eventually run a public CVS tree that the various subsystem 
maintainers might be granted commit access to, because I didn't want to 
confuse the issue.

You don't use CVS, this proposal is not asking you to use CVS, and you seem 
to dislike other people using CVS.  I'm under the impression this is because 
CVS blurs together the patches you then need to receive and code review to do 
your job as architect of the Linux kernel.

It takes a skilled human being to extract clean patches from a CVS tree and 
feed them on to you in the format you prefer: one per email, plain text, with 
a description at the top.  Clean, atomic patches that do exactly one thing, 
and don't have any cross-reference dependencies on any other pending patches 
in the patch set.  No automated CVS-like tool will ever be able to do that 
AND resolve conflicts between patches.  You need a human.

Extracting patches out of a CVS tree and hand-massaging them into a format 
you would accept would be a big part of the integration maintainer's job.  
If they chose to run a CVS tree.  (Backing the patches out if you rejected 
the whole idea of that particular patch would be a lot of work too, but it 
would also be part of the integration maintainer's job.)

Rob
