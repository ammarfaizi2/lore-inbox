Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUAXF7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUAXF7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:59:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:57536 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266870AbUAXF7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:59:54 -0500
Date: Fri, 23 Jan 2004 22:00:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: s_kieu@hotmail.com
Cc: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 pppd: page allocation failure
Message-Id: <20040123220055.78ad46fb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401241236230.29380@darkstar.example.net>
References: <Pine.LNX.4.53.0401241236230.29380@darkstar.example.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

haiquy@yahoo.com wrote:
>
> 
> Hi,
> 
> This did not happen with 2.6.1-mm4 . The system is still running fine
> at the moment but I find several message in the dmesg output
> 
> pppd: page allocation failure. order:4, mode:0xd0
> Call Trace: [<c01388f0>]  [<c013895f>]  [<c013b48c>]  [<c013b79e>]  [<c013bae4>]  [<c01fc177>]  [<c01f87b4>]  [<c01f6bd1>]  [<c014e742>]  [<c015f299>]  [<c02b2f67>]

Please enable CONFIG_KALLSYMS to get a symbolic trace and resend that.


