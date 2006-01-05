Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWAEVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWAEVUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWAEVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:20:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:33548 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932224AbWAEVUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:20:14 -0500
Date: Thu, 5 Jan 2006 22:20:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.git checkout error
Message-ID: <20060105212009.GD7142@w.ods.org>
References: <20060105170910.M70902@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105170910.M70902@linuxwireless.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:11:27AM -0600, Alejandro Bonilla wrote:
> 
> receiving file list ... done
> 
> sent 121 bytes  received 922 bytes  695.33 bytes/sec
> total size is 103831840  speedup is 99551.14
> * committish: db9edfd7e339ca4113153d887e782dd05be5a9eb  HEAD from
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Updating from 88026842b0a760145aa71d69e74fbc9ec118ca44 to
> db9edfd7e339ca4113153d887e782dd05be5a9eb.
> fatal: Entry 'Makefile' not uptodate. Cannot merge.
> debian:~/linux-2.6#

I believe you have local modifications in your makefile that have not
been committed nor reverted. Do a git-diff, you should not see anything
before the merge.

> .Alejandro

Willy

