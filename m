Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUGHWk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUGHWk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUGHWk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:40:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:25832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265151AbUGHWk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:40:28 -0400
Date: Thu, 8 Jul 2004 15:43:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: evil@g-house.de, drightler@technicalogic.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 "Unable to handle kernel paging request" plus kobject_get
 badness
Message-Id: <20040708154328.557bb2d5.akpm@osdl.org>
In-Reply-To: <20040708150223.2fa765bf.rddunlap@osdl.org>
References: <004101c462c8$b870fbd0$0200000a@darkomen.lan>
	<40EDC3C3.40302@g-house.de>
	<20040708150223.2fa765bf.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Andrew, do you recognize this Oops?
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108905677320691&w=2

Nope.  Looks like the IDE I/O error triggered some bug in JBD.
