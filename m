Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTFJUEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:04:21 -0400
Received: from mail.webmaster.com ([216.152.64.131]:44794 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262306AbTFJUDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:03:45 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <xyko_ig@ig.com.br>, <linux-kernel@vger.kernel.org>
Subject: RE: Wrong number of cpus detected/reported
Date: Tue, 10 Jun 2003 13:17:31 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGECIDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3EE6287E.4050707@ipiranga.com.br>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>
> first of all please apologize me because I didn't subscribe the list. I
> really even don't know if this list is the appropriate place to have my
> question discussed but I didn't found any better one.
>
> I installed a RedHat 7.1 system on a 4 way 1.4 Gz Compaq DL580 server
> with kernel 2.4.2 and everything goes right. Because of some other
> prerequisite needs I had to upgrade the kernel to 2.4.9-34.
>
> After the upgrade the system is reporting that the machine has 8 cpu
> instead of 4. I have been looking for some kind of information on the
> Internet (www.google.com/linux) about that but I didn't have success.

	This is correct. The machine has 8 logical CPUs implemented inside 4
physical CPUs. For more information, search Intel's web pages about
'hyperthreading'.

	DS


