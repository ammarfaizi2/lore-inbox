Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVCKQSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVCKQSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCKQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:18:33 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:5898 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261188AbVCKQSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:18:17 -0500
Message-Id: <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Adrian Bunk <bunk@stusta.de>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version 
In-Reply-To: Your message of "Thu, 10 Mar 2005 23:53:40 +0100."
             <20050310225340.GD3205@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>  <20050310225340.GD3205@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 13:48:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bunk@stusta.de said:
> This patch is still wrong.
> It seems my comment on this [1] was lost:
> <--  snip  -->
> This line has to be something like
> ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> && \
>    HEAVILY_PATCHED_SUSE_GCC ) 

> I hope SuSE has added some #define to distinguish what they call  "gcc
> 3.3.4" from GNU gcc 3.3.4 

It wasn't lost - I am just disinclined to cater to distros making their
gcc lie about its version.

				Jeff

