Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbTGLQuH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbTGLQuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:50:06 -0400
Received: from dm4-153.slc.aros.net ([66.219.220.153]:61889 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S266164AbTGLQuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:50:02 -0400
Message-ID: <3F103FAD.4050506@aros.net>
Date: Sat, 12 Jul 2003 11:04:45 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shrybman@sympatico.ca
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Paul Clements <Paul.Clements@SteelEye.com>
Subject: [PATCH] nbd.c compile warning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have large block device support turned on or off in your kernel 
build options? I believe this compile warning came as a result of 
compiling without CONFIG_LBD - I hadn't tried building that way and 
would then have missed this problem. Just typecasting the result as your 
patch does should work correctly either way though. I'll make sure to 
pull it into my NBD sources but you will need to get Andrew Morton or 
Paul Clements to pick up the patch for it to move into the kernel distro 
stream. I've CC'd them on this message to help expedite this. Thanks!

