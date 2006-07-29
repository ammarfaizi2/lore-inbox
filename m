Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWG2PLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWG2PLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWG2PLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:11:25 -0400
Received: from web36701.mail.mud.yahoo.com ([209.191.85.35]:26280 "HELO
	web36701.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751559AbWG2PLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:11:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eL59tW3QuYtqx6+khk33FyXoAzj+fzmyBXx6Vo6Bs3ZtLUKIBHVm9ZvYM0rBvIvuYNT3BZCIWHWHIHve3B6Knj7V9/XwjQfJk4nW6NrV968X/mc1QpQa8c8qoUC1diFHs5QSgPeYPGbUWYx9N1rnAvzMNjcp+1qR14TX4fJrvYQ=  ;
Message-ID: <20060729151124.82074.qmail@web36701.mail.mud.yahoo.com>
Date: Sat, 29 Jul 2006 08:11:24 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060728040446.GD5356@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - fixed those.

--- Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Thu, Jul 27, 2006 at 08:34:06PM -0700, Alex Dubov
> wrote:
> > The driver is called tifmxx and available from:
> > http://developer.berlios.de/projects/tifmxx/
> 
> 1. Usual name for spinlocking flags is
> 
> 	unsigned long flags;
> 
> 2. Preferred CS for if statements is
> 
> 	if (foo)
> 		bar; /* two lines no matter how short */
> 
> 3. Check for NULL at the start of tifm_7xx1_remove
> is unnecessary.
>    You've saved valid fm at probe time, right?
> 
> 4. If ->suspend and ->resume are not implemented why
> add dummy ones?
> 
> 5. 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
