Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVBFMMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVBFMMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVBFMMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:12:03 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:38924 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261194AbVBFML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:11:57 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: akpm@osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Date: Sun, 6 Feb 2005 13:11:49 +0100
User-Agent: KMail/1.7.91
References: <20050206113635.GA30109@wotan.suse.de>
In-Reply-To: <20050206113635.GA30109@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061311.51019.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My proposal is to recompile broken software with cflags += -Wa,--noexecstack.
This works fine with e.g. 2.6.10+pax/i386.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
