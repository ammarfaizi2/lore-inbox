Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRB1ABt>; Tue, 27 Feb 2001 19:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbRB1ABi>; Tue, 27 Feb 2001 19:01:38 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:530 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129740AbRB1ABa>;
	Tue, 27 Feb 2001 19:01:30 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Linux kernel list" <linux-kernel@vger.kernel.org>
Subject: Building autofs
Date: Wed, 28 Feb 2001 09:00:39 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGENDDCAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010228001221.P21238@garloff.etpnet.phys.tue.nl>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I'm trying to use autofs for the first time and am running into some
problems. First,  the documentation seems quite weak, that is, I'm not sure
if what I have is what I should have. I managed to find an autofs version 4
pre 9 tarball on the kernel mirrors. This seem the latest but is still a bit
old and the referenced home page doesn't seem any newer. My real problem,
however, is that when I try to build it I get this error:

lookup_program.c:147: `OPEN_MAX' undeclared (first use in this function)

My understanding is that OPEN_MAX is defined in linux/limits.h but I
hesitate to change the code since I would expect this to build out of the
box.


	Cas someone who is using autofs give me some pointers? Am I on the right
track?

Thanks,

--Rainer

