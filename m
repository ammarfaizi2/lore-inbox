Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVIQUe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVIQUe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVIQUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 16:34:57 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:25742 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751191AbVIQUe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 16:34:56 -0400
Message-ID: <432C7DEA.9060103@free.fr>
Date: Sat, 17 Sep 2005 22:34:50 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: EZD driver and hdx=remap.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I spend lot's of hours to figure that my kernel need hdx=remap to 
understand EZD disk.

It was very long because I had to figure it have something to do with 
EZD and then find the solution (easy).

If EZD drive are not remapped, why in fs/partitions/msdos.c, there 
aren't some info in case of EZD driver about hdx=remap option ?

Futhermore it will much cleanner to panic in this case, as log spaming 
could mask the message.

Matthieu
