Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVKKOTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVKKOTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKKOTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:19:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21408 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750779AbVKKOTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:19:05 -0500
Date: Fri, 11 Nov 2005 15:19:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
In-Reply-To: <43737EC7.6090109@zytor.com>
Message-ID: <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Nov 2005, H. Peter Anvin wrote:

> May I *STRONGLY* urge you to name that something different. "lost+found" 
> is a name with special properties in Unix; for example, many backup 
> solutions will ignore a directory with that name.

Two reasons against renaming:

- we call it fsck-objects for a reason. We are working on a file system, 
  which just so happens to be implemented in user space, not kernel space.
  If lost+found has to find a new name, so does fsck-objects.

- lost+found has a special meaning, granted. So, a backup would not be 
  made of it. So what? I *don't* want it backup'ed. I want to repair what
  was wrong with it. When I repaired it, the result is stored somewhere
  else. To backup lost+found would make as much sense as to backup /tmp.

Ciao,
Dscho


