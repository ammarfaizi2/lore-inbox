Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUFCPYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUFCPYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFCPYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:24:00 -0400
Received: from mail.broadpark.no ([217.13.4.2]:45967 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S264397AbUFCPNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:13:13 -0400
Message-ID: <40BF4007.8010102@linux-user.net>
Date: Thu, 03 Jun 2004 17:13:11 +0200
From: Daniel Andersen <anddan@linux-user.net>
Reply-To: daniel@linux-user.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Pernet <WebMonster@idsa.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: .config question
References: <s0bf4d74.020@idfw.idsa.ch>
In-Reply-To: <s0bf4d74.020@idfw.idsa.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Pernet wrote:

> I've got a kernel already installed in my machine (SuSe Pro 9). I would
> like to modify something and recompile the kernel. Since it has been
> installed from rpm, there is no .config in /usr/src/linux. Is there any
> way to create this file from the image and modules, so i do not need to
> verify all my config prior to change something ?

Suse Pro 9.1 has a copy of the running kernelconfig in /proc/config.gz.
Type 'zcat /proc/config.gz > /usr/src/linux/.confg' to copy it to your 
sourcetree.

Daniel Andersen
