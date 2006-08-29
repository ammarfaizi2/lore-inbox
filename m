Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWH2Psz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWH2Psz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWH2Psz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:48:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10455 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965028AbWH2Psy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:48:54 -0400
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <44F40E76.5000809@sw.ru>
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru>
	 <1156357820.12011.45.camel@localhost.localdomain>  <44F40E76.5000809@sw.ru>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 08:48:45 -0700
Message-Id: <1156866525.5408.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 13:52 +0400, Kirill Korotaev wrote:
> 1. we will introduce a separate patch moving this pointer
>   into mirroring array
> 2. this pointer is still required for _user_ pages tracking,
>   that's why I don't follow your suggestion right now... 

You hadn't mentioned that part. ;)

I guess we'll wait for the user patches before these can go any further.

-- Dave

