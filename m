Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751933AbWJWLfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWJWLfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWJWLfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:35:24 -0400
Received: from web32402.mail.mud.yahoo.com ([68.142.207.195]:52324 "HELO
	web32402.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751933AbWJWLfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:35:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5m+Rgidi49wM/ji5ipBtK7jAj2LNcZkHMmDJ7RofesolL6UDR+AG49DddMc4b1xHI5kljSvnaxV48GktI2QiwSZoaWbDjD6Sab1xnf04ZBJjS78W/RTdPjmyNBJ/TXWe60zQWwAw4sXwnlXGxSFsbzi+1++bwMDsPYBiESXcURc=  ;
Message-ID: <20061023113523.50028.qmail@web32402.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 04:35:23 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161600064.19388.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> However by then it has already dynamically linked with explicit GPLONLY
> symbols so it cannot then load a binary windows driver but should unload
> itself or refuse to load anything but the GPL ndis drivers (of which
> afaik only one exists), and even then they expect an environment
> incompatible with the Linux kernel.

So the idea of tainting is to _prevent_ any binary code being loaded into
kernel, even if kernel is marked as having binary code loaded, which I
thought was the purpose of tainting (so that people not interested in dealing
with binary code know they don't have/want to)? If that is the goal, how do
you know this scheme of adding names to module loader in kernel guarantees
that (now or in future)? 

Thanks,
Giri

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
