Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287328AbSAGW5e>; Mon, 7 Jan 2002 17:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287330AbSAGW5X>; Mon, 7 Jan 2002 17:57:23 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:55515 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id <S287328AbSAGW5U>;
	Mon, 7 Jan 2002 17:57:20 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 14:56:30 -0800 (PST)
Message-Id: <200201072256.OAA12152@kankakee.wrs.com>
To: Dautrevaux@microprocess.com, dewar@gnat.com, guerby@acm.org
Subject: RE: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
> To: "'Laurent Guerby'" <guerby@acm.org>, dewar@gnat.com
> Date: Mon, 7 Jan 2002 14:29:15 +0100 

> It seems to me that you are right,

That's unfortunate.

> but there is other cases; for example:
> 	X := T(0)*256 + T(1);
> compiled on a big endian architecture may well generate just one
> 16-bit word read...

Not in my word, not in gcc's world.  That is just broken and wrong.

If you want/need the gcc doc to expound on this, write it up, and
we'll add it.
