Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGLAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGLAGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWGLAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:06:34 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:46833 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932280AbWGLAGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:06:32 -0400
Message-ID: <44B43D0A.8010803@namesys.com>
Date: Tue, 11 Jul 2006 17:06:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clay Barnes <clay.barnes@gmail.com>
CC: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>
Subject: Re: short term task list for Reiser4
References: <44B42064.4070802@namesys.com>	<20060711222903.GG9220@HAL_5000D.tc.ph.cox.net>	<44B43019.9010402@namesys.com> <20060711235553.GH9220@HAL_5000D.tc.ph.cox.net>
In-Reply-To: <20060711235553.GH9220@HAL_5000D.tc.ph.cox.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reiser4 generally could use some knobs controlling things like whether
we trickle data slowly and continuously

>
>If you have a lazy write policy, what exactly is gained by intentionally
>delaying writes (beyond a certain size that is necessary to make things
>like dancing trees actually effecient)?  If you trickle some data to
>disk, then when memory pressure causes (or an app calls) a big sync,
>then you have less to actually write.  What I'm suggesting, now, is not
>a major write policy change, but rather a light process that is limited
>to extremely low resource use (I/O, CPU, etc.).  It would take some of
>the edge off of major syncs, and for many (most?) non-server users, it
>could wholly eliminate memory pressure-induced heavy syncs.
>
>--Clay
>
>
>  
>

