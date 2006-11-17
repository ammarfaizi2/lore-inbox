Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755970AbWKQWSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbWKQWSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbWKQWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:18:51 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:25430 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1755970AbWKQWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:18:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Cu0xYz0hEuvHPH6MHHyD5cOGkr6RkXTOwx9sDdiKI7vtGdh/DKydCsoaKuZ/jHuahDKZz3QDRAEHQVq8FhhNP+YYhD7n0JcuDFUpWsxOfTDzCwsWM9wh0sNXYc7bgw2ZG+u6dVzLhETwMAm3t8TEHK3zCYVFhB8BcVVEQYvG9vw=  ;
X-YMail-OSG: 39LhTFUVM1mkx9mw4nz908S9BKZQ9ZEwQD_0NmwU6yNscLedVkme3V3Xl3Pm8MbwXX0c1JFhy7t5cBcvcD9UIk94yxmkZi5AepsitQcqy7cgSRdKIac-
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Make x86_64 udelay() round up instead of down - try2
Date: Fri, 17 Nov 2006 23:18:47 +0100
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <20061101163043.GA2602@elf.ucw.cz> <20061117193047.13096.60874.stgit@americanbeauty.home.lan> <20061117140050.7f19acf8.akpm@osdl.org>
In-Reply-To: <20061117140050.7f19acf8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611172318.47578.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 23:00, Andrew Morton wrote:
> On Fri, 17 Nov 2006 20:30:47 +0100
>
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > Port two patches from i386 to x86_64 delay.c to make sure all rounding is
> > done upward instead of downward.
>
> Andi already has a patch in his, tree, only it's different.
>
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/make-x86_64-ud
>elay-round-up-instead-of-down.
Ok, a fixed-up version of what I sent - I implemented Pavel's suggestion, the 
the choice is just a taste matter.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
