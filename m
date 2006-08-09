Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWHICdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWHICdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHICdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:33:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55209 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030420AbWHICdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:33:18 -0400
Message-ID: <44D9496A.7040800@zytor.com>
Date: Tue, 08 Aug 2006 19:33:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
In-Reply-To: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> I often heard of the OOM probelm in NFS, but don't know what it is.
> Now I am developing a NFS based system and found my system memory
> (server side) is used too fast. I checked the code but didn't find
> memory leaking. So I suspect I run into OOM issue.
> 
> Can someone help me and give me a brief description on OOM issue?
> 
> Many many thanks!

What I suspect you're talking about has to do with a network client 
running out of memory and not being able to talk to the network.  The 
server isn't affected.

	-hpa
