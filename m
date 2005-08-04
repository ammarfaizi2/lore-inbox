Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVHDGeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVHDGeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVHDGeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:34:10 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43441 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261868AbVHDGeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:34:09 -0400
Date: Thu, 4 Aug 2005 08:34:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Walter <walter@mbo.de>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: ReiserFS crashing
In-Reply-To: <42F1B44A.9030203@mbo.de>
Message-ID: <Pine.LNX.4.61.0508040828210.22272@yvahk01.tjqt.qr>
References: <42F0ADEE.7020405@mbo.de> <Pine.LNX.4.61.0508040808000.22272@yvahk01.tjqt.qr>
 <42F1B44A.9030203@mbo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thank you very much for your replies. What was making me think it's probably a
> bug was this line:
>
>> kernel BUG at fs/reiserfs/journal.c:494!
>
> Drive is accessible again - I just wanted to be sure this isn't a bug in
> ReiserFS.

Depends on the way you look at it. Cases such as yours are handled by 
reiserfsck, and moving reiserfsck into kernel space would be ... uh ... well, 
probably not the best. (Though, ever seen an auto repairing online
filesystem? ;-) Especially when fsck comes to interactive questions about what 
to repair/discard.


Jan Engelhardt
-- 
