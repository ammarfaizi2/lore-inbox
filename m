Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUIFLlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUIFLlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUIFLlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:41:22 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:9354 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267740AbUIFLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:41:21 -0400
Message-ID: <413C4CD2.3010200@yahoo.com.au>
Date: Mon, 06 Sep 2004 21:41:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allocate correct amount of memory for pid hash
References: <412824BE.4040801@yahoo.com.au> <4128252E.1080002@yahoo.com.au> <20040906113541.GR7716@krispykreme>
In-Reply-To: <20040906113541.GR7716@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

>>Also, account for all the pid hashes when reporting hash memory usage.
> 
> 
> It looks like we are now allocating twice as much memory as required.
> How does this look?
> 

Fine. Good catch thanks Anton.
