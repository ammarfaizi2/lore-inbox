Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHTTsl>; Mon, 20 Aug 2001 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbRHTTsb>; Mon, 20 Aug 2001 15:48:31 -0400
Received: from mail.webmaster.com ([216.152.64.131]:33666 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S268974AbRHTTs0>; Mon, 20 Aug 2001 15:48:26 -0400
From: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() says closed socket readable
Date: Mon, 20 Aug 2001 12:48:40 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMEEDNDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E15Yq81-0006o8-00@shell2.shore.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, a socket that's never been connected isn't readable, hence
> select() shouldn't be returning a value of 1 on it.

	It is readable. A read that produces an error is still a read.

	DS

