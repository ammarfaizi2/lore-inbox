Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVFRDS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVFRDS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFRDS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:18:28 -0400
Received: from web61219.mail.yahoo.com ([209.73.179.53]:45413 "HELO
	web61219.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262028AbVFRDJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 23:09:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mLH2ssou14ri8Wyn/dKV+C9mt+RtPsUky/VT6rvEJ9sDJt+5YtpKRGL15nsqO+S+SqFlaBej5A9wCkJCJj1oYBzPTUBNAYR6Y3x6ExnhYiSQdWwiR8KCY+tSzLccFJLRMEpvSeMY/25MvY3Nf4GYw/CIS4CrLRe3AagrP4yRBco=  ;
Message-ID: <20050618030946.75406.qmail@web61219.mail.yahoo.com>
Date: Fri, 17 Jun 2005 20:09:46 -0700 (PDT)
From: movq movq <movq_64@yahoo.com>
Subject: Re: missing kfree in fs/ext3/balloc.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

Kernel version = 2.6.12 stable

--- movq movq <movq_64@yahoo.com> wrote:

> This is my first post, so be kind. Perhaps I am
> wrong
> here, but I was looking through fs/ext3/balloc.c and
> noticed this line:
> 
> line 268
> ...
> block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
> ...
> 
> But I do not see this chunk of memory ever
> kfree()'d.
> Is there a reason for this or is this kfree() just
> missing?
> 
> - Thanks
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> 



		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com
