Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVIUTRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVIUTRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVIUTRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:17:04 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55212 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751342AbVIUTRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:17:02 -0400
Message-ID: <4331B1AC.6060000@namesys.com>
Date: Wed, 21 Sep 2005 12:17:00 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vs <vs@thebsh.namesys.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: latest patches degrade reiser4 performance substantially
References: <4331A9BD.5030006@namesys.com> <20050921115256.6a11ab8d.akpm@osdl.org>
In-Reply-To: <20050921115256.6a11ab8d.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>At the this time we have no idea which patch is responsible, probably in
>>a day or two we'll have a patch to fix it.
>>
>>    
>>
>
>OK.  I assume this performance change is demonstrable in just
>2.6.14-rc2+reiser4?  Beware that there are other changes in the -mm lineup
>which might cause regressions.  Notably
>
>	mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch
>
>and
>
>	per-task-predictive-write-throttling-1.patch
>	per-task-predictive-write-throttling-1-tweaks.patch
>
>
>
>  
>
 I'll have vs check to make sure it is reiser4 changes causing the
drop.  Thanks much for the suggestion we check that.
