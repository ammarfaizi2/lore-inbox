Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVGVQJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVGVQJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVGVQJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:09:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:974 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261296AbVGVQJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:09:17 -0400
Message-ID: <42E11A03.6030400@namesys.com>
Date: Fri, 22 Jul 2005 20:08:35 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] type safe list
References: <42E0FBA0.6050502@namesys.com> <20050722144153.GA17220@infradead.org>
In-Reply-To: <20050722144153.GA17220@infradead.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Christoph Hellwig wrote:
> On Fri, Jul 22, 2005 at 05:58:56PM +0400, Vladimir V. Saveliev wrote:
> 
>>Hello
>>
>>This is implementaion of circular doubly linked parametrized list.
>>It is similar to the list implementation in include/linux/list.h
>>but it also provides type safety which allows to detect some of list 
>>manipulating
>>mistakes as soon as they happen.
> 
> 
> This looks like an ugly solution in search of a problem.  Just use
> normal list.h list and get rid of this mess.
> 
ok.
We have also type safe hash chain implementation.
I guess it also does not have a chance to get in?
