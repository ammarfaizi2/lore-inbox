Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUGOBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUGOBXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGOBXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:23:46 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:38370 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261236AbUGOBGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 21:06:39 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040715004350.GD3411@holomorphy.com>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
	 <1089776640.15336.2557.camel@abyss.home>
	 <20040713211721.05781fb7.akpm@osdl.org>
	 <1089848823.15336.3895.camel@abyss.home>
	 <20040715000438.GS974@dualathlon.random>
	 <20040715004350.GD3411@holomorphy.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089853483.15336.4035.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 18:04:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 17:43, William Lee Irwin III wrote:

> 
> I wouldn't be so quick to dismiss it. There are enough physical
> placement issues already even without pinned userspace pages.

Hi,

You and Andrey are mentioning "pinned" pages. Does this corresponds to 
locked (ie memlock()) pages ? 

In my case I did not have any locked pages at all. 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



