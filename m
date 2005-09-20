Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVITP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVITP0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVITP0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:26:19 -0400
Received: from trixi.wincor-nixdorf.com ([217.115.67.77]:18613 "EHLO
	trixi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S965038AbVITP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:26:19 -0400
Message-ID: <43302899.6090506@wincor-nixdorf.com>
Date: Tue, 20 Sep 2005 17:19:53 +0200
From: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Organization: Wincor Nixdorf
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
References: <43301BC4.9080305@wincor-nixdorf.com> <1127230327.6276.1.camel@localhost.localdomain>
In-Reply-To: <1127230327.6276.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,


will try to get a strace.


Thanx,

Peter

Alan Cox wrote:
> On Maw, 2005-09-20 at 16:25 +0200, Peter Duellings wrote:
> 
>>Obviously there are some cases where the accept() system call does
>>not set the errno variable if the accept() system call returns
>>with a value less than zero:
> 
> 
> Not actually possible. The kernel returns a positive value, zero or a
> negative value which is the errno code negated. It has no mechanism to
> return a negative value and not error.
> 
> What does strace show for the failing case ?
> 


