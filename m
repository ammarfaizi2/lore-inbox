Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUEKVWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUEKVWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEKVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:22:53 -0400
Received: from cathy.bmts.com ([216.183.128.202]:11650 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S263663AbUEKVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:22:50 -0400
Date: Tue, 11 May 2004 17:22:08 -0400
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Cc: rene.herman@keyaccess.nl
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040511172208.4d9f210f.mikeserv@bmts.com>
In-Reply-To: <40A0B7DA.9090905@keyaccess.nl>
References: <409F4944.4090501@keyaccess.nl>
	<200405102125.51947.bzolnier@elka.pw.edu.pl>
	<409FF068.30902@keyaccess.nl>
	<200405102352.24091.bzolnier@elka.pw.edu.pl>
	<20040510215626.6a5552f2.akpm@osdl.org>
	<20040510221729.3b8e93da.akpm@osdl.org>
	<40A0B7DA.9090905@keyaccess.nl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 13:24:10 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> Have attached a patch of what I'm currently using against 2.6.6 just in 
> case anyone interested lost track. It's bart+morton+hack.
> 
> Rene.
> 

[linux-2.6.6_rollup.diff  text/plain (3726 bytes)]

I applied your bart+morton+hack rollup earlier today and it seems to be doing the right thing by me. The only problem I was having, was the suspend on restart and bios initialization delay (~ 15 seconds) because of it. That niggle was bugging me a bit and I'm glad to have it corrected.

So thanks Rene, Andrew and Bartlomiej :-)

Mike
