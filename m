Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUJPQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUJPQgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268778AbUJPQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:36:06 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:44955 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268728AbUJPQgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:36:03 -0400
Message-ID: <41714E02.3020501@drzeus.cx>
Date: Sat, 16 Oct 2004 18:36:18 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Tasklet usage?
References: <416FCD3E.8010605@drzeus.cx> <41713B79.3080406@drzeus.cx> <52brf2bqfz.fsf@topspin.com>
In-Reply-To: <52brf2bqfz.fsf@topspin.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>unsigned long will be 64 bits on a 64-bit system.  There are many
>places in the Linux kernel where we assume that void * and long are
>the same size.
>
> - Roland
>  
>
Just out of curiosity, how do you declare a 32-bit int then? I thought 
longlong would be the 64-bit int under gcc and long stay as it is.

Rgds
Pierre

