Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRDRUeg>; Wed, 18 Apr 2001 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135313AbRDRUe1>; Wed, 18 Apr 2001 16:34:27 -0400
Received: from mail1.home.nl ([213.51.129.162]:9967 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S135293AbRDRUeQ>;
	Wed, 18 Apr 2001 16:34:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
To: linux-kernel@vger.kernel.org
Subject: /dev/pts question
Date: Wed, 18 Apr 2001 22:35:44 +0200
X-Mailer: KMail [version 1.2]
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01041822354404.00617@ElkOS>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

as I understand, /dev/pts was created
to make an end to the overload in /dev/<devices>
and let the kernel put the entries in /dev/pts
when they are used/needed/installed.

but still, when I enable /dev/pts, I have to
keep the /dev/<devices> for backward compatibility
with already installed applications that rely on them.

would it be possible/sane to make like a
/dev/* (some sort of a /dev/B-compatible) besides
/dev/pts, where the kernel `translates' the
/dev/<device> request to /dev/* and then
`translate' that to the correct /dev/pts entry ??

at least, something like that...
-- 
elko

