Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265289AbUF3JgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUF3JgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUF3JgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:36:13 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:55564 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S265289AbUF3JgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:36:13 -0400
From: jan@talentex.demon.co.uk
To: linux-kernel@vger.kernel.org
Subject: malloc overlap?
Date: Wed, 30 Jun 2004 10:36:12 +0100
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <E1BfbVk-000PFO-0W@anchor-post-32.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question is probably misplaced - sorry about that, but one has to start somewhere, and I think it isn't too far out. Here goes:

I am developing a program that mallocs a struct, which contains a pointer to another struct, which gets malloced. Then I realloc the first buffer to be one element larger and assign something to an element in the second element - and this action overwrites part of the second level struct. After much tracing I am now sure that the buffers somehow have come to overlap. Is this a known error? I imagine that if the kernel had this kind of problem, it wouldn't run far, but surely memory allocation is handled in the kernel?

I hope somebody can point me in the right direction - and thank you for helping! I am not on the list, so please reply directly.

/jan


