Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279991AbRJ3QFZ>; Tue, 30 Oct 2001 11:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279971AbRJ3QFN>; Tue, 30 Oct 2001 11:05:13 -0500
Received: from sushi.toad.net ([162.33.130.105]:65171 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279963AbRJ3QFE>;
	Tue, 30 Oct 2001 11:05:04 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 11:04:56 -0500
Message-Id: <1004457897.4243.106.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  I just noticed that your problem was with 
suspend, not standby.  The same scenario could occur
with suspend, of course.  However, the scenario does
not match the problem you describe.  I don't see how
a change to the apm driver could cause a suspend to
turn into something that looks like a standby-plus-crash.

Are you sure that the machine is hanged: SysRq-s,
SysRq-u, SysRq-b doesn't work?

--
Thomas

