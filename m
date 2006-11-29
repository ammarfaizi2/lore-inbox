Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934202AbWK2Fyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934202AbWK2Fyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934366AbWK2Fyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:54:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934190AbWK2Fyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:54:44 -0500
Message-ID: <456D2259.1050306@redhat.com>
Date: Wed, 29 Nov 2006 01:02:01 -0500
From: Wendy Cheng <wcheng@redhat.com>
Reply-To: wcheng@redhat.com
Organization: Red Hat
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com>	<20061127165239.9616cbc9.akpm@osdl.org>	<456CACF3.7030200@redhat.com> <20061128162144.8051998a.akpm@osdl.org>
In-Reply-To: <20061128162144.8051998a.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>We shouldn't export this particular implementation to modules because it
>has bad failure modes.  There might be a case for exposing an
>i_sb_list-based API or, perhaps better, a max-unused-inodes mount option.
>
>
>  
>
Ok, thanks for looking into this - it is appreciated. I'll try to figure 
out something else.

-- Wendy

