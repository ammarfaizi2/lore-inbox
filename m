Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUHSChZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUHSChZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUHSChZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:37:25 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:35225 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268013AbUHSChT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:37:19 -0400
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.0
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mmazur@pld-linux.org, mmazur@kernel.pl
Content-Type: text/plain
Organization: 
Message-Id: <1092873833.5761.2002.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Aug 2004 20:03:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never mind that last one. This is nicer:

extern int getpagesize(void);
#define PAGE_SIZE ((unsigned long)getpagesize())
#define PAGE_SHIFT ((unsigned long[]){12,13,14,-1,15,-1,-1,-1,16}[PAGE_SIZE>>13])


