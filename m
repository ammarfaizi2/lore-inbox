Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVGZXLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVGZXLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVGZXLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:11:43 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:21615 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262311AbVGZWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:36:37 -0400
Message-ID: <16727.134.134.136.2.1122417419.squirrel@chretien.genwebhost.com>
In-Reply-To: <ee588a54050726152014f56899@mail.gmail.com>
References: <ee588a54050726152014f56899@mail.gmail.com>
Date: Tue, 26 Jul 2005 15:36:59 -0700 (PDT)
Subject: Re: [PATCH 2.6.12 1/1] docs: updated some code docs
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Xose Vazquez Perez" <xose.vazquez@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Xose Vazquez Perez said:
> Updated docs about how to write and submit patches/code.
>

Parts of this should conflict with a patch in -mm from a few weeks ago.
then I check and don't see it there.... hrm, wonder what happened to it.


-Separate each logical change into its own patch.
+Separate each _logical changes_ into its own patch.
                        change
or drop "each" and change "its own patch"
to "a single patch file."

 On the other hand, if you make a single change to numerous files,
-group those changes into a single patch.  Thus a single logical change
-is contained within a single patch.
+group those changes into a single patch.  Thus single logical changes
+are contained within a single patch.

It's better in the original form.

+Do not send more than 15 patches at once to the vger mailing lists!!!

Only in one place, please.

-- 
~Randy

