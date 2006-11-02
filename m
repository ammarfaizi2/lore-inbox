Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752789AbWKBKHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbWKBKHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbWKBKHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:07:15 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:16768 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752789AbWKBKHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:07:13 -0500
X-Sasl-enc: AM9LryLvdkebQGwRnGSIY/R4mXw2Zt3svY1ZlnFog/Jj 1162462033
Date: Thu, 2 Nov 2006 18:07:08 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with /proc/mounts and statvfs (implementing df).
In-Reply-To: <200610281537.07145.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0611021804290.15477@raven.themaw.net>
References: <200610281537.07145.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Rob Landley wrote:

> I'm trying to implement a df command that works based on /proc/mounts and 
> statvfs.  To make this work, I need to be able to detect duplicate mounts 
> (including --bind mounts), and I need to be able to detect overmounted 
> filesystems.

I need to do quite a bit with mount tables in autofs.
You may wish to look at lib/mounts.c in autofs version 5.

Current state of play can be found in files located at
http://www.kernel.org/pub/linux/daemons/autofs/v5.

Ian

