Return-Path: <linux-kernel-owner+w=401wt.eu-S964953AbWLMNIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWLMNIE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWLMNIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:08:04 -0500
Received: from smtp.nokia.com ([131.228.20.172]:58631 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964953AbWLMNIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:08:00 -0500
X-Greylist: delayed 1665 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 08:08:00 EST
Subject: Re: 2.6.19-mm1: drivers/mtd/ubi/debug.c: unused variable
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20061211204616.GJ28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
	 <20061211204616.GJ28443@stusta.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Dec 2006 14:36:51 +0200
Message-Id: <1166013411.16396.15.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 13 Dec 2006 12:36:52.0191 (UTC) FILETIME=[5D9D2EF0:01C71EB3]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 21:46 +0100, Adrian Bunk wrote:
> It doesn't seem to be intended that in ubi_dbg_vprint_nolock() the 
> variable "caller" is never assigned any value different from 0.
>  

thanks, fixed in our GIT tree.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

