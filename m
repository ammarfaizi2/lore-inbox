Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTH3XdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTH3XdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:33:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:42136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbTH3XdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:33:10 -0400
Date: Sat, 30 Aug 2003 16:36:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: OOps in 2.6.0-test4-mm3-1
Message-Id: <20030830163653.6ac5464f.akpm@osdl.org>
In-Reply-To: <20030830232003.GB898@matchmail.com>
References: <20030828235649.61074690.akpm@osdl.org>
	<20030830014309.GA898@matchmail.com>
	<20030829200926.3e2b7eb6.akpm@osdl.org>
	<20030830232003.GB898@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> Though, is there any reason why
>  2.6.0-test2-mm1 doesn't oops too? 

Of course.  drivers/scsi/hosts.c was changed and it broke.

