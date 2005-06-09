Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVFIV25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVFIV25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVFIV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:28:56 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:62613 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262475AbVFIV2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:28:04 -0400
Message-ID: <42A8B3FF.20306@google.com>
Date: Thu, 09 Jun 2005 14:26:23 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: unexport and static __mntput()
References: <2cd57c90050609043125bd3e1f@mail.gmail.com>
In-Reply-To: <2cd57c90050609043125bd3e1f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello,
> 
> I don't see any reasons that modules should call __mntput.
> And it's only called by mntput(). Or anyone knows any outer code depends on it?
> 
> Adrian, a patch unexport and static it?
> 

It's used indirectly by autofs, autofs4 and nfsd.

Mike Waychison
