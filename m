Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRKHOvI>; Thu, 8 Nov 2001 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280159AbRKHOu7>; Thu, 8 Nov 2001 09:50:59 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:35716 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S280110AbRKHOur>; Thu, 8 Nov 2001 09:50:47 -0500
Message-Id: <200111081450.fA8EoLb13654@mysql.sashanet.com>
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: Oktay Akbal <oktay.akbal@s-tec.de>
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
Date: Thu, 8 Nov 2001 07:50:21 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111080627320.12430-100000@omega.hbh.net>
In-Reply-To: <Pine.LNX.4.40.0111080627320.12430-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 November 2001 10:33 pm, Oktay Akbal wrote:
> Same test with ext2 on the same partition showed no problems.
> 
> Reran the test with reiserfs and the system got unresponsive
> again.
> 
> Did you use reiserfs ?

Yes, I did. I suspected from the trace resolve this could very well be 
ReiserFS issue.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
