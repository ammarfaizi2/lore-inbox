Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUFFIEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUFFIEK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFFIEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:04:09 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:55714 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S263032AbUFFIEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:04:05 -0400
Message-ID: <40C2E045.8090708@codeweavers.com>
Date: Sun, 06 Jun 2004 18:13:41 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org>
In-Reply-To: <20040606073241.GA6214@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:

> if you have a need for a special virtual memory layout please use your
> own binary loader as I already suggested earlier in the thread, i.e.
> binfmt_pecoff.

We are using our own user space loader now, but a kernel space loader is 
  neither portable or practical.

The Wine project is used by many people and companies for both comercial 
and non-comercial purposes.  In the spirit of cooperation, it would be 
nice if somebody let us know when they're going to make a change that is 
going to break Wine, and provide a way for us to workaround that change, 
or even better maintain real binary compatability...

It seems Linus's kernel does that quite well, but some vendors seem not 
to care too much about breaking Wine.

Mike
