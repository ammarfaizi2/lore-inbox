Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTIEAiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTIEAiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:38:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:27783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261507AbTIEAiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:38:16 -0400
Date: Thu, 4 Sep 2003 17:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: aquamodem@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4  on to mpegs and DVB
Message-Id: <20030904173901.7ab1b4bb.akpm@osdl.org>
In-Reply-To: <3F57D776.4050404@ameritech.net>
References: <3F560DC6.2090709@ameritech.net>
	<3F57D776.4050404@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watermodem <aquamodem@ameritech.net> wrote:
>
> The DVD looked and sounded great, but, it was using 
>  98% of the CPU!  2.4 never used that much.

A kernel profile will be needed to diagnose this further.  Please see
Documentation/basic_profiling.txt

Also check that you have selected the correct IDE chipsets in
configuration.  And post your dmesg output, especially the IDE bits.

