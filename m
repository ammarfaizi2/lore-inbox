Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUCVHtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUCVHtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:49:32 -0500
Received: from ns.suse.de ([195.135.220.2]:60576 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261797AbUCVHtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:49:31 -0500
Date: Mon, 22 Mar 2004 08:49:29 +0100
From: Olaf Hering <olh@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] defer free_initmem() if we have no /init
Message-ID: <20040322074929.GB15682@suse.de>
References: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403220132060.28727@montezuma.fsmlabs.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 22, Zwane Mwaikambo wrote:

> In the absence of /init and other nice boot goodies, we fall through to
> prepare_namespace() so we shall require initmem to complete boot.

Andrew, please restore the previous version of the patch. The 3 liner is
much more obvious. 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
