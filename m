Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSG1X4p>; Sun, 28 Jul 2002 19:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSG1X4p>; Sun, 28 Jul 2002 19:56:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39156 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318015AbSG1X4o>;
	Sun, 28 Jul 2002 19:56:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Jul 2002 01:59:42 +0200 (MEST)
Message-Id: <UTC200207282359.g6SNxgW24418.aeb@smtp.cwi.nl>
To: axboe@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Sun, 28 Jul 2002, Jens Axboe wrote:

    > But the crap still got merged, sigh... Yet again an excellent point of
    > why stuff like this should go through the maintainer. Apparently Linus
    > blindly applies this stuff.

    Ehh, since there is no proactive maintainer for SCSI, I don't have much
    choice, do I?

    SCSI has been maintainerless for the last few years. Right now three
    people work on it to some degree (Doug Ledford, James Bottomley and you),
    but I don't get timely patches, and neither does apparently anybody else.

    Case in point: I was debugging some USB storage issues with Matthew Dharm
    yesterday, and he sent me patches to the SCSI subsystem that he claims
    were supposedly considered valid on the scsi mailing list back in May.

    Guess what? I've not seen the patches from any of the three people I
    consider closest to being maintainers.

    So your "should go through the maintainer" complaint is obviously a bunch
    of bull. Feel free to step up to the plate, but before you do, don't throw
    rocks in glass houses.

Ha, Linus,

Yes, an interesting discussion with Matthew Dharm.
I have seen several messages discussing the topic today -
linux-scsi is not silent about it.

You killed the idea of maintainers yourself, proclaiming
that you did not work with maintainers but with lieutenants.

In the mathematical world, if someone wants to publish a paper,
it is sent to a handful of referees. These reply "reject",
or "accept", or "accept, but correct the following mistakes ...",
or procrastinate so much that the editor takes some random decision
herself.

Such a system would not be unreasonable in the Linux world.
A SCSI patch is sent to linux-scsi and also to the five people
active today in the area. They reply, preferably both to you
and on linux-scsi, and if within one or two days after a positive
reply no negative reply comes in, then apparently there are
no objections.

In the absence of a single active maintainer, peer review is a
good alternative.

Andries


[By the way, have you asked these people to be maintainer?
Many people are too modest to suggest themselves, but will
accept when asked.]
