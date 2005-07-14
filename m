Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVGNLzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVGNLzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVGNLzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:55:37 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:11733 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263024AbVGNLz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:55:27 -0400
Message-ID: <42D652A3.50505@g-house.de>
Date: Thu, 14 Jul 2005 13:55:15 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Ed Tomlinson <tomlins@cam.org>, Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GIT tree broken? (rsync depreciated)
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>	 <1120816858.4688.4.camel@localhost.localdomain>	 <200507080728.17192.tomlins@cam.org> <1120825225.4689.13.camel@localhost.localdomain>
In-Reply-To: <1120825225.4689.13.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop schrieb:
> After resyncing cogito to the latest version (which incorporates the
> 'pack' changes, which were causing the failure), it does indeed work
> again, when using rsync.
> 

hm, i haven't updated my git-tree (linux-2.6.git) for a while and i got
similiar error messages. i updated cogito to:

% cg-version
cogito-0.12.1 (cbec08d191d36126ddaf021961cc8995794b4a72)

and the "cannot map sha1 file..." errors went away. now i get:

Applying changes...
error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
error: Could not read c101f3136cc98a003d0d16be6fab7d0d950581a6
error: Could not read c101f3136cc98a003d0d16be6fab7d0d950581a6
error: Could not read c101f3136cc98a003d0d16be6fab7d0d950581a6
error: Could not read a18bcb7450840f07a772a45229de4811d930f461
Merging 99f95e5286df2f69edab8a04c7080d986ee4233b ->
514fd7fd01d378a7b5584c657d9807fc28f22079
        to 62351cc38d3eaf3de0327054dd6ebc039f4da80d...
fatal: failed to unpack tree object bda3910b7737a4fac464792657ffedcba185d799
cg-merge: git-read-tree failed (merge likely blocked by local changes)

i *think* i did not make any local changes, but if i did - i want to get
rid ofthem and want a clean tree.

cg-status prints a lot of files with a "D" in front of it but "cg-status
-h" does not know about the "D" status flag....

any hints for this one?

thank you,
Christian.
-- 
BOFH excuse #378:

Operators killed by year 2000 bug bite.

