Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSKVU5Z>; Fri, 22 Nov 2002 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSKVU5Z>; Fri, 22 Nov 2002 15:57:25 -0500
Received: from web21204.mail.yahoo.com ([216.136.131.77]:49465 "HELO
	web21204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264638AbSKVU5Y>; Fri, 22 Nov 2002 15:57:24 -0500
Message-ID: <20021122210433.2292.qmail@web21204.mail.yahoo.com>
Date: Fri, 22 Nov 2002 13:04:33 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: Replacng arp_generic_ops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
If I wanted to get notification of every IPv4 arp
request made in a system, I believe I'd need to
replace the solicit entry in arp_generic_ops with a
call to my own function rather than arp_solicit. The
problem I face is that I coudn't find a
straightforward way to get access to get at neigh->ops
when loaded as a module. Perhaps doing a neigh_create
and then replacing neigh->ops is the easiest way? Any
suggestions/advice would be much appreciated. 
Melkor



__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus – Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
