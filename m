Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267987AbRG3VAR>; Mon, 30 Jul 2001 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbRG3U75>; Mon, 30 Jul 2001 16:59:57 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:65030 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267918AbRG3U7p>; Mon, 30 Jul 2001 16:59:45 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: serial console and kernel 2.4
Date: Mon, 30 Jul 2001 20:59:51 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9k4hs7$m7u$1@ncc1701.cistron.net>
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr> <20010730223632.B82B.GAUTIER@email.enst.fr>
X-Trace: ncc1701.cistron.net 996526791 22782 195.64.65.67 (30 Jul 2001 20:59:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010730223632.B82B.GAUTIER@email.enst.fr>,
Fabrice Gautier  <gautier@email.enst.fr> wrote:
>> Is there something that I'm missing ? (something new with the kernel 2.4
>> that is required for a serial console that was not required with the 2.2 ?)
>
>It's probably a bug in your init.
>I had the same, my init is busybox init, but maybe the sysv init has/had
>the same problem.

It has, was fixed in 2.80 which I put on
ftp.cistron.nl/pub/people/miquels/software/ a few days ago.

It's probably wise to wait for your vendor to ship a new sysvinit
package, or for all I know some vendors might have patched 2.78 already.

Mike.
-- 
"dselect has a user interface which scares small children"
	-- Theodore Tso, on debian-devel

