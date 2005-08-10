Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVHJRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVHJRNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVHJRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:13:33 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:20473 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965212AbVHJRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:13:32 -0400
Message-ID: <42FA364C.9090605@gentoo.org>
Date: Wed, 10 Aug 2005 18:15:56 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kristoffer <kfs1@online.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: captive-ntfs FUSE support?
References: <op.svanygid3czpo8@myhost.localdomain>
In-Reply-To: <op.svanygid3czpo8@myhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristoffer wrote:
> why?:
> Since LUFS is no longer maintained and FUSE is. since to use the LUFIS  
> bridge you have to install LUFS,

This is not true. lufis is a compatibility layer on top of FUSE which provides 
the same API as lufs (thereby allowing you to load lufs modules into fuse). It 
does not actually rely on any part of lufs.

As for captive, I don't think its worth the effort. It has severe memory 
problems and Linux-NTFS development is going quite fast anyway.

Daniel
