Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUFWQCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUFWQCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUFWQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:01:36 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:45074 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S265786AbUFWQBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:01:15 -0400
From: "gud" <gud@eth.net>
Reply-to: gud@eth.net
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Jun 2004 21:38:55 +0550
Subject: Elastic Quota File System (EQFS)
X-Mailer: DMailWeb Web to Mail Gateway 2.8d, http://netwinsite.com/top_mail.htm
Message-id: <40d9ab17.118.0@eth.net>
X-User-Info: 202.9.130.223
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2004 15:53:34.0343 (UTC) FILETIME=[3D3A6970:01C4593A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

	I think I should discuss this in the list...

	Recently I'm into developing an Elastic Quota File System (EQFS). This
file system works on a simple concept ... give it to others if you're not
using it, let others use it, but on the guarantee that you get it back when
you need it!!

	Here I'm talking about disk quotas. In any typical network, e.g.
sourceforge, each user is given a fixed amount of quota. 100 Mb in case of
sourceforge. 100 Mb is way over some project requirements and too small for
some projects. EQFS tries to solve this problem by exploiting the users'
usage behavior at runtime. That is the user's quota which he doesn't need
is given to the users who need it, but on 100% assurance that the originl
user can any time reclaim his/her quota.

	Before getting into implementation details I want to have public opinion
about this system. All EQFS tries to do is it maximizes the disk space
usage, which otherwise is wasted if the user doesn't really need the
allocated user..on the other hand it helps avoid the starvation of the user
who needs more space. It also helps administrator to get away with the
problem of variable quota needs..as EQFS itself adjusts according to the
user needs.


regs,
AG


	
http://www.ddsl.net
