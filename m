Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbTF3JdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbTF3JdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:33:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:61434 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265820AbTF3JdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:33:19 -0400
Date: Mon, 30 Jun 2003 02:47:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, zwane@linuxpower.ca, efault@gmx.de
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Message-Id: <20030630024749.77be1d6d.akpm@digeo.com>
In-Reply-To: <200306301135.37960.m.c.p@wolk-project.de>
References: <200306281516.12975.kernel@kolivas.org>
	<200306291457.40524.kernel@kolivas.org>
	<200306301535.49732.kernel@kolivas.org>
	<200306301135.37960.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2003 09:47:38.0893 (UTC) FILETIME=[A4765BD0:01C33EEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
>  "make -j16 bzImage modules" of a 2.5.73-mm2 tree makes XMMS skip easily

Well it would.   Try not to do that.  We shouldn't optimise
for things which basically nobody would do.

`make -j2' would be more interesting.  

