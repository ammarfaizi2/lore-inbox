Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTEPSjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTEPSjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:39:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:18959 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264551AbTEPSjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:39:07 -0400
Date: Fri, 16 May 2003 20:48:28 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Message-ID: <20030516204828.A4497@electric-eye.fr.zoreil.com>
References: <200305161640.43804.baldrick@wanadoo.fr> <200305161539.h4GFdLGi018236@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305161539.h4GFdLGi018236@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Fri, May 16, 2003 at 11:39:21AM -0400
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams <chas@locutus.cmf.nrl.navy.mil> :
[...]
> locking to proc in the 2.5 that should make proc safer (but not very
> elegant--perhaps elegance with come with the seq conversion).

Well...

[romieu@crap linux-2.5.69-1.1042.101.10-to-1.1083]$ grep goto changes/patches/atm-proc-seq* | wc -l
     26

Time to merge this jewel of code once again I guess.

--
Ueimor
