Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVE0Cen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVE0Cen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVE0Cen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:34:43 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:33932 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261449AbVE0Cel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:34:41 -0400
Date: Thu, 26 May 2005 19:34:37 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating patches for source
Message-Id: <20050526193437.2fd71090.rdunlap@xenotime.net>
In-Reply-To: <42967627.5040306@linuxwireless.org>
References: <42967627.5040306@linuxwireless.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005 20:21:43 -0500 Alejandro Bonilla wrote:

| Hi,
| 
|     Quick and fast question here. I'm starting to create patches (diff) 
| :-) so, I googled for a while and most say that one could use the diff 
| -up or diff -Naur. They both look to me very similar and honestly -up 
| works for me. Still, what command will make the cleanest patch and which 
| one is mostly used?

You looked at 'man diff', right?

and linux/Documentation/SubmittingPatches, which says:
Use "diff -up" or "diff -uprN" to create patches.

So you use the options that are appropriate for your patches.

If you are patching only one file (or a few files in the same
directory), -up is usually fine.
If you have patches in multiple directories and you want diff
to search in subdirectories for patches, you need to use -r
(recursive).
If you are adding new files, you need to use -N.

Is there a specific problem that you are trying to solve?

---
~Randy
