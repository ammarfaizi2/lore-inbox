Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUJaBBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUJaBBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUJaBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:01:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:1686 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261453AbUJaBBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:01:49 -0400
Date: Sat, 30 Oct 2004 21:01:43 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Margit Schubert-While <margitsw@t-online.de>, prism54-private@prism54.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] prism54: make some functions static
Message-ID: <20041031010143.GI7887@ruslug.rutgers.edu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Margit Schubert-While <margitsw@t-online.de>,
	prism54-private@prism54.org, netdev@oss.sgi.com, jgarzik@pobox.com,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041030054534.GC4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030054534.GC4374@stusta.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:45:34AM +0200, Adrian Bunk wrote:
> As a side effect it turned out that the mgt_unlatch_all function was 
> completely unused, and I've therefore removed it.

mgt_unlatch_all is there as work in progress. We currently set ESSID to
commit but we may need more work than that depending on the mode we're
in. Even though we're not using it right now we may use it soon due to
WPA. Please don't remove it.

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
