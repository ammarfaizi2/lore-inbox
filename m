Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268063AbUIFOeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268063AbUIFOeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFOeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:34:21 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:55509 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S268063AbUIFOeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:34:12 -0400
Message-ID: <413C754C.9040908@quark.didntduck.org>
Date: Mon, 06 Sep 2004 10:33:48 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] explicity align tss->stack
References: <4139C6E2.1050000@quark.didntduck.org> <20040905144103.487afba6.akpm@osdl.org>
In-Reply-To: <20040905144103.487afba6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brian Gerst <bgerst@quark.didntduck.org> wrote:
> 
>>Use an alignment attribute on the stack member of struct tss_struct 
>> instead of padding.  Also mark the limit of the TSS segment.
> 
> 
> The TSS code got a significant working-over recently.  Please take a look
> at next -mm, see if this patch is still appropriate?
> 

There are no conflicts in -mm3.

--
				Brian Gerst
