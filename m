Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUBXPuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUBXPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:50:44 -0500
Received: from mail5.iserv.net ([204.177.184.155]:27858 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S262288AbUBXPuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:50:24 -0500
Message-ID: <403B72C2.1010705@didntduck.org>
Date: Tue, 24 Feb 2004 10:50:26 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Soboroff <ian.soboroff@nist.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why are 2.6 modules so huge?
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
In-Reply-To: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff wrote:
> Can anyone help me understand why 2.6-series kernel modules are so
> huge?
> 
> $ cd /lib/modules
> $ ls -l */kernel/fs/vfat
> 2.4.20-18.8bigmem/kernel/fs/vfat:
> total 20
> -rw-r--r--    1 root     root        17678 May 29  2003 vfat.o
> 
> 2.4.23-xfs/kernel/fs/vfat:
> total 20
> -rw-r--r--    1 root     root        17614 Dec  3 18:04 vfat.o
> 
> 2.6.0/kernel/fs/vfat:
> total 288
> -rw-r--r--    1 root     root       288738 Feb 11 16:47 vfat.ko
> 
> 2.6.3/kernel/fs/vfat:
> total 288
> -rw-r--r--    1 root     root       289086 Feb 24 10:09 vfat.ko
> 
> Ian
> 

You probably have debugging config options enabled (ie CONFIG_DEBUG_INFO).

--
				Brian Gerst
