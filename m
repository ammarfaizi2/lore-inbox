Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTFCQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbTFCQu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:50:57 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:50441 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265105AbTFCQu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:50:57 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Michael Frank <mflt1@micrologica.com.hk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>
Subject: Re: Linux 2.4.21-rc6
Date: Tue, 3 Jun 2003 19:03:49 +0200
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <200306040030.27640.mflt1@micrologica.com.hk> <200306031859.59197.m.c.p@wolk-project.de>
In-Reply-To: <200306031859.59197.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306031903.06297.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 18:59, Marc-Christian Petersen wrote:

Hi again,

> well, very easy one:
> dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> then use your mouse, your apps, switch between them, use them, _w/o_
> pauses, delay, stops or kinda that. If _that_ will work flawlessly for
> everyone, then it is fixed, if not, it _needs_ to be fixed.
I forgot to mention. If you have more than 2GB free memory (the above one will 
create a 2GB file), the test is useless.

Have less memory free, so the machine will swap, doesn't matter if the same 
disk or another or whatever!

ciao, Marc

