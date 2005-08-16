Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVHPRPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVHPRPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVHPRPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:15:45 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:43629 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S1030254AbVHPRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:15:44 -0400
Message-ID: <43021EC5.9030803@google.com>
Date: Tue, 16 Aug 2005 10:13:41 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: coywolf@sosdg.org, akpm@osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] unexport __mntput()
References: <20050815015357.GA16778@everest.sosdg.org> <430014EA.4030404@google.com> <Pine.LNX.4.61.0508161320510.30973@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508161320510.30973@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>Nfsd uses it to serve up nfs exports that don't cross mountpoints (or do, if
>>"crossmnt" is specified in /etc/exports.
> 
> 
> Is not this called nohide?
> 
> 

On the command line it's a synonym, but the nfs-utils uses 
NFSEXP_CROSSMOUNT to tell the kernel.

Mike Waychison
