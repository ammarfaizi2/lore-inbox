Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUGLDRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUGLDRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGLDRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:17:19 -0400
Received: from main.gmane.org ([80.91.224.249]:48043 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266695AbUGLDRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:17:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: synaptics driver
Date: Sun, 11 Jul 2004 23:17:08 -0400
Message-ID: <ccsvrq$frj$1@sea.gmane.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080155.38937.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
In-Reply-To: <200407080155.38937.dtor_core@ameritech.net>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again. I just wanted to let you know that under 2.6.8-mm1, I'm still 
experiencing the same synaptics-not-being-detected-at-system-startup bug 
that happens with the newer input patches since earlier -mm kernels. 
Sometimes my synaptics touchpad will get detected correctly (generally 
after a cold reboot) and both my trackpoint & touchpad will work 
properly, but other times (after warm reboot usually) the trackpoint 
won't work, and the Synaptics X driver won't enable the extra touchpad 
features. Removing & reloading the psmouse module after the system has 
booted fixes the problem. With the more recent kernels, this seems to 
happen even if psmouse is loaded before all the USB controller modules.

