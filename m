Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUISOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUISOSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 10:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269241AbUISOSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 10:18:42 -0400
Received: from mail4.ewetel.de ([212.6.122.28]:62961 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S269100AbUISOSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 10:18:41 -0400
To: Mike Mestnik <cheako911@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Design for setting video modes, ownership of sysfs attributes
In-Reply-To: <2G6Et-6D7-31@gated-at.bofh.it>
References: <2FYdH-10h-5@gated-at.bofh.it> <2G6Et-6D7-31@gated-at.bofh.it>
Date: Sun, 19 Sep 2004 16:18:37 +0200
Message-Id: <E1C92WT-00005z-7q@localhost>
From: Pascal Schmidt <pascal.schmidt@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 12:00:21 +0200, you wrote in linux.kernel:

> The FDs 0, 1 and posibly 2 will be the console. 

*The* console? They can all be connected to different console
devices (think redirection). I'd think for video mode questions,
you'd look at stdout...

-- 
Ciao,
Pascal
