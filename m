Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131312AbRCWRj7>; Fri, 23 Mar 2001 12:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRCWRjt>; Fri, 23 Mar 2001 12:39:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131312AbRCWRjo>; Fri, 23 Mar 2001 12:39:44 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Fri, 23 Mar 2001 17:32:46 +0000 (GMT)
Cc: dwguest@win.tue.nl (Guest section DW),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk> from "James A. Sutherland" at Mar 23, 2001 05:26:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gVQf-00056B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That depends what you mean by "must not". If it's your missile guidance
> system, aircraft autopilot or life support system, the system must not run
> out of memory in the first place. If the system breaks down badly, killing
> init and thus panicking (hence rebooting, if the system is set up that
> way) seems the best approach.

Ultra reliable systems dont contain memory allocators. There are good reasons
for this but the design trade offs are rather hard to make in a real world
environment

Solving the trivial overcommit case is not a difficult task but since I don't
believe it is needed I'll wait for those who moan so loudly to do it

