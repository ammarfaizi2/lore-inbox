Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262753AbTCVL7G>; Sat, 22 Mar 2003 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262759AbTCVL7G>; Sat, 22 Mar 2003 06:59:06 -0500
Received: from mailer.pg.infn.it ([193.205.222.2]:1803 "EHLO mailer.pg.infn.it")
	by vger.kernel.org with ESMTP id <S262753AbTCVL7E>;
	Sat, 22 Mar 2003 06:59:04 -0500
Date: Sat, 22 Mar 2003 13:10:07 +0100
From: Gabriele Alberti <gabriele.alberti@pg.infn.it>
To: lkml <linux-kernel@vger.kernel.org>
Subject: raid5 question
Message-ID: <20030322131007.A17792@pc-ams7.pg.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I wanted to ask a (maybe stupid, I'm not a kernel hacker) question.
In software raid5 (linux 2.4.18) why when there is a multiple disk failure
(no spare disks) does the raid device continue to work? It couldn't be better
if the device hangs? It happened to me to have 2 disks stopped
(I don't know why, they were not broken) but the raid5 device continued to work,
so when I restarted the system and the "faulty" disks, the raid (mkraid -f)
actually restored the filesystem but with filesystem corruption; I guess
this happened because someone wrote to the faulty raid.

Does it work so or I'm missing something? (I'm sure about the n.2 :-)

Thanks in advance, best regards,

        Gabriele Alberti

