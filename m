Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUHZSm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUHZSm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUHZSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:39:38 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:53210 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S269334AbUHZSiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:38:08 -0400
Message-ID: <412E2E0D.8040401@dgreaves.com>
Date: Thu, 26 Aug 2004 19:38:05 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
References: <412E2058.60302@rtlogic.com>
In-Reply-To: <412E2058.60302@rtlogic.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rolenc wrote:

> I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
> 2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
> not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
> something?  I want to read data from disk with readahead and drop the 
> data from the page cache as soon as I am done with it. Do I have to 
> call fadvise with POSIX_FADV_DONTNEED after every read?

And will this work over nfs?

David
