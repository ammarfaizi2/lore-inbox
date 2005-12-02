Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVLBWk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVLBWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVLBWk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:40:26 -0500
Received: from web32108.mail.mud.yahoo.com ([68.142.207.122]:35975 "HELO
	web32108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750846AbVLBWkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:40:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KVk8AiRJ4JxTNfH31sT1G/bithGAP5DzqA5kr8TtchLyqtLTDzgLJCWmwywDB19nj/7lTtNl+r2LJPHrd6JDDIZclwK9CSuiG6ailmk/irSI4+rLT/gq8GIiKqANFbV0FtlNkREyOgrE5WbM36ImTouGc7IC3JFvuiVt5B82/bc=  ;
Message-ID: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
Date: Fri, 2 Dec 2005 14:40:25 -0800 (PST)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: copy_from_user/copy_to_user question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a question regarding copy_to_user and
copy_from_user, specifically the conditons and
situations when they can be used.

Firstly, I guess it is always safe to use these
funtions when making an ioctl call. 

But my question is: Are there any specific
circumstances or conditions when these functions don't
have to be used, but at the same time ensure that no
page fault occurs and crashes the system.

The reason I ask is, there is some software that I am
dealing with that just don't use these functions. 

Secondly, they seem to use memcpy as opposed to using
copy_to_user/copy_from_user which is also very
dangerous.

Any thoughts?

Vinay



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

