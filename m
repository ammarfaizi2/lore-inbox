Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTDYTZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTDYTZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:25:31 -0400
Received: from [12.47.58.68] ([12.47.58.68]:30442 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263673AbTDYTZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:25:30 -0400
Date: Fri, 25 Apr 2003 12:38:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: jjs <jjs@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm2+e100=trouble
Message-Id: <20030425123851.4604053f.akpm@digeo.com>
In-Reply-To: <3EA97735.8070005@tmsusa.com>
References: <3EA97735.8070005@tmsusa.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2003 19:37:37.0039 (UTC) FILETIME=[202349F0:01C30B62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjs <jjs@tmsusa.com> wrote:
>
> Hello -
> 
> This may be of interest...
> ...
> 
> EIP is at apply_alternatives+0x0/0xf0
> ...

You need to delete the __init from the definition of apply_alternatives().

