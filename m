Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267161AbSKTBQY>; Tue, 19 Nov 2002 20:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267167AbSKTBQY>; Tue, 19 Nov 2002 20:16:24 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:51208 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S267161AbSKTBQY>; Tue, 19 Nov 2002 20:16:24 -0500
Message-ID: <YWxhbg==.fbe902c8c023f46b8c6a468b793820bf@1037755344.cotse.net>
Date: Tue, 19 Nov 2002 20:22:24 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: MAX_ARG_PAGES
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Recently I had a user who needed to remove 17k files all at once and
received the message 'rm: Argument list too long'.  In his case an rm
-rf on the directory itself solved his problem, but after a quick web
search, it seems that the value of MAX_ARG_PAGES in
include/linux/binfmts.h (32) is responsible for this limitation.  Could
this value possibly be increased safely?  I'm curious, is there some
other limitation that has been breached in the 2.5 series that would
make it safer to increase MAX_ARG_PAGES?

-alan


