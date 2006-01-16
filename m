Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWAPXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWAPXaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWAPXaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:30:00 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56970 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbWAPX37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:29:59 -0500
Date: Tue, 17 Jan 2006 00:29:57 +0100
From: Olaf Hering <olh@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060116232957.GA26342@suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43CC2AF8.4050802@sw.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 17, Kirill Korotaev wrote:

> Olaf, can you please check if my patch for busy inodes from -mm tree 
> helps you?

I cant reprpoduce it at will, thats the thing. It likely happens with NFS
mounts. agruen@suse.de did some work recently. But I remember even with
these changes (for a 2.6.13), the busy inodes did not disappear.

Merging your patch into our cvs will give it more testing, I will do
that tomorrow if noone disagrees.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
