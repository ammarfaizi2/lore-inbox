Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272319AbTGaAEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272363AbTGaAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:04:46 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:54984 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S272319AbTGaAEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:04:45 -0400
Message-ID: <3F28611F.5080807@genebrew.com>
Date: Wed, 30 Jul 2003 20:21:51 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Stefano Rivoir <s.rivoir@gts.it>, lista1@telia.com,
       linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
References: <20030729182138.76ff2d96.lista1@telia.com>	<3F2786E9.9010808@gts.it>	<20030730035524.65cfc39a.akpm@osdl.org>	<3F27ECFA.5020005@gts.it> <20030730114428.7e629895.akpm@osdl.org>
In-Reply-To: <20030730114428.7e629895.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stefano Rivoir <s.rivoir@gts.it> wrote:
> 
>>I think I've got it. 2.4 fails to load DRI, so when X is up there is
>> memory available until the load of gnucash, the last operation. 2.6
>> loads dri and probably this eats too much too early, causing the
>> system to touch swap since the first operation after X startup.
> 
> 
> hrm, Why should loading DRI in X consume a significant amount of memory?

Perhaps this is a machine with "shared video memory", like the Intel 
integrated video chipsets (i810). Stefano?

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com

