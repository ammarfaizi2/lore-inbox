Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVKILO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVKILO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVKILO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:14:56 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:3593 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751364AbVKILOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:14:55 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <E1EZInj-0001F1-Aj@ZenIV.linux.org.uk> (message from Al Viro on
	Tue, 08 Nov 2005 02:01:31 +0000)
Subject: Re: [PATCH 13/18] shared mounts handling: move
References: <E1EZInj-0001F1-Aj@ZenIV.linux.org.uk>
Message-Id: <E1EZnuQ-0001Bg-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 12:14:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ram Pai <linuxram@us.ibm.com>
> Date: 1131402003 -0500
> 
> Handling of mount --move in presense of shared mounts (see
> Documentation/sharedsubtree.txt in the end of patch series
> for detailed description).

This patch seems to be totally wrong.  It copies the mounts instead of
moving them in the propagated cases.

Am I missing something?

Miklos
