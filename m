Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIJKHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIJKHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:07:10 -0400
Received: from hal-5.inet.it ([213.92.5.24]:6126 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261670AbTIJKHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:07:08 -0400
Message-ID: <021201c37783$e5b87cc0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 12:11:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mean 11561 cycles to:
> 
> page fault
> copy zero page
> install copy
> remove copy
> 
> (= write every page from MAP_ANON region and unmap, repeatedly)
> 
> I think that makes a clear case for avoiding page copies.

Thanks.
