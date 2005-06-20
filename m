Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFTSnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFTSnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFTSnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:43:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32929 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261435AbVFTSnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:43:53 -0400
Message-ID: <42B70E62.5070704@pobox.com>
Date: Mon, 20 Jun 2005 14:43:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Telemaque Ndizihiwe <telendiz@eircom.net>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telemaque Ndizihiwe wrote:
> This Patch replaces two GOTO statements and their corresponding LABELs
> with one IF_ELSE statement in /fs/open.c, 2.6.12 kernel.
> The patch keeps the same implementation of sys_open system call, it only 
> makes the code smaller and easy to read.
> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


If you don't like goto, don't read kernel code!

	Jeff


