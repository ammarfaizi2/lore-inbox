Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCZUtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUCZUtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:49:36 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:46604 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261210AbUCZUte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:49:34 -0500
Message-ID: <40649754.8000007@cs.wisc.edu>
Date: Fri, 26 Mar 2004 12:49:24 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2][RFC] add detailed error values to block layer
References: <4059AC04.3060109@cs.wisc.edu> <20040326001808.GA5110@elf.ucw.cz>
In-Reply-To: <20040326001808.GA5110@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>+enum {
>>+	BLK_SUCCESS,
>>+	BLK_ERR,		/* Generic error like -EIO */
>>+	BLK_FATAL_DEV,		/* Fatal driver error */
> 
> 
> 	perhaps this should be fatal *device* error?
> 

Hi,

Your right thanks.

Mike Christie

