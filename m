Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbUDRBNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 21:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUDRBNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 21:13:18 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:21988 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S264136AbUDRBNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 21:13:12 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: "'Francois Romieu'" <romieu@fr.zoreil.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.6-rc1 caused dedicated Quake 3 server to core dump
Date: Sat, 17 Apr 2004 20:13:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040417195930.A16784@electric-eye.fr.zoreil.com>
Thread-Index: AcQkrkEzmsMeu3EOQaOv1OLIKYGKzgAMkDXQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <E1BF0rr-0007TG-Rh@server.cyberhostplus.biz>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, I meant to include that in my first email.  It's the latest NVidia
driver 1.0-5336.  I know, I know, but it's worked fine with 2.6.5 and all
previous.  Also, just the dedicated quake 3 server core dumped, the quake 3
client running on the same machine did not crash.  At the time of the crash,
there were four clients connected to the quake 3 server.  I realize the
NVidia driver could have corrupted some memory some where else, but if
that's the case, I would have thought it would have shown this behavior
previous, and not just with 2.6.6-rc1.  Unless of course, something in
2.6.6-rc1 specifically altered something the NVidia driver makes use of.  I
guess.  :-) 

Steve


-----Original Message-----
From: Francois Romieu [mailto:romieu@fr.zoreil.com] 
Sent: Saturday, April 17, 2004 1:00 PM
To: Stephen Lee
Cc: linux-kernel@vger.kernel.org; steve@tuxsoft.com
Subject: Re: 2.6.6-rc1 caused dedicated Quake 3 server to core dump

Stephen Lee <slee@tuxsoft.com> :
> For years now, I've been running a dedicated Quake 3 server on my linux
> box.  Last night, was the first time I've ever seen a core dump with
> Quake.  2.6.5 was and is now running fine, but under 2.6.6-rc1 it core
> dumped within about 30 minutes with the attached dmesg output.  I am

Which binary module are you using ?

--
Ueimor




