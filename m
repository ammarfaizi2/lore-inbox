Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULAIih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULAIih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULAIig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:38:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5079 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261366AbULAIiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:38:20 -0500
Date: Wed, 1 Dec 2004 09:38:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: a replacement for dnotify
In-Reply-To: <20041130150345.K14339@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.53.0412010937500.17975@yvahk01.tjqt.qr>
References: <1101854070.4493.52.camel@betsy.boston.ximian.com>
 <20041130150345.K14339@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	user = find_user(current->user->uid);
>> +	if (!user)
>> +		return -ENOMEM;
>
>Can just be:
>
>	get_uid(current->user);

What about current->euid?



Jan Engelhardt
-- 
ENOSPC
