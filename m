Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285236AbRLSLB5>; Wed, 19 Dec 2001 06:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285241AbRLSLBr>; Wed, 19 Dec 2001 06:01:47 -0500
Received: from [213.196.40.44] ([213.196.40.44]:48867 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S285236AbRLSLBf>;
	Wed, 19 Dec 2001 06:01:35 -0500
Date: Wed, 19 Dec 2001 12:05:30 +0100 (CET)
From: <bvermeul@devel.blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1: rpm -qa stalls in select
Message-ID: <Pine.LNX.4.33.0112191203120.7857-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having a problem with 2.5.1, namely that I can't seem
to get rpm -qa to run correctly. I've done an strace, and
that shows that rpm times out on a select/read/write somewhere.
Easy enough to reproduce, rpm -qa will stall during the run.

This is on linux 2.5.1, with the kill patch backed out.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

