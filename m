Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWDXG02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWDXG02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 02:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWDXG02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 02:26:28 -0400
Received: from mail.suse.de ([195.135.220.2]:6604 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750832AbWDXG01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 02:26:27 -0400
Date: Mon, 24 Apr 2006 08:26:26 +0200
From: Olaf Hering <olh@suse.de>
To: Steve French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CIFS] Readdir fixes to allow search to start at arbitrary position
Message-ID: <20060424062626.GA17021@suse.de>
References: <200604231711.k3NHBMKd013080@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200604231711.k3NHBMKd013080@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 23, Linux Kernel Mailing List wrote:

> committer Steve French <sfrench@us.ibm.com> Sat, 22 Apr 2006 15:53:05 +0000
> 
> [CIFS] Readdir fixes to allow search to start at arbitrary position
> in directory
> 
> Also includes first part of fix to compensate for servers which forget
> to return . and .. as well as updates to changelog and cifs readme.

This results in a compile error in 2.6.17-rc2-git5 if
CONFIG_CIFS_EXPERIMENTAL is not enabled.

fs/cifs/connect.c:3451: undefined reference to `CIFS_SessSetup'

