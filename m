Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUJKD4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUJKD4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUJKD4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:56:55 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3728 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268670AbUJKD4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:56:53 -0400
Subject: Re: 2.6.9-rc3-mm3 woes
From: Lee Revell <rlrevell@joe-job.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4169FCB5.8050808@tequila.co.jp>
References: <4169FCB5.8050808@tequila.co.jp>
Content-Type: text/plain
Message-Id: <1097465881.1418.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 10 Oct 2004 23:38:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 23:23, Clemens Schwaighofer wrote:
> System: debian/unstable
> 
> I just tried 2.6.9-rc3-mm3 and I have two problems:
> 
> - - he calls himself 2.6.9-rc-mm31, yeah 31. I don't know where this comes
> from, because in the Makefile itself it is mm3. Whatever makes him do
> that, I don't know, but he install himselfs like this, perhaps the
> problems come from that
> 

Weird.  Works fine here.  Maybe this is a bug in the debian build
process, try building from a fresh tree.

> - - cdrecord segfaults. Again I don't know if this is cdrecords fault or
> not, but cdrecord works fine with 2.6.9-rc2-mm1
> 

You might need to back out this patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch

HTH,

Lee


