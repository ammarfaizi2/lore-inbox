Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTBPAoY>; Sat, 15 Feb 2003 19:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBPAoX>; Sat, 15 Feb 2003 19:44:23 -0500
Received: from [81.2.122.30] ([81.2.122.30]:7685 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265508AbTBPAoX>;
	Sat, 15 Feb 2003 19:44:23 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302160055.h1G0tXd6000804@darkstar.example.net>
Subject: Re: openbkweb-0.0
To: arashi@yomerashi.yi.org
Date: Sun, 16 Feb 2003 00:55:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302160046.h1G0k9IA000718@darkstar.example.net> from "John Bradford" at Feb 16, 2003 12:46:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why can't we have a mailing list that sends out a diff for each
> update?
> 
> That way, all you need is:
> 
> :0
> * ^X-Mailing-List: up-to-the-second-linux-patches
> | /usr/local/bin/apply_patches
> 
> and
> 
> #!/bin/sh
> cd /usr/src/linux-current
> cat | patch -p1
> mail $username

Sorry, I meant just:

#!/bin/sh
cd /usr/src/linux-current
cat | patch -p1

John.
