Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTETS1C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTETS1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:27:02 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:38567 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263866AbTETS1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:27:01 -0400
Subject: Re: DHCP
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: root@chaos.analogic.com
Cc: Gerald Stuhrberg <grstuhrberg@aaahawk.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0305201312270.5930@chaos>
References: <200305191821.h4JILlE12026@adam.yggdrasil.com>
	 <1053398767.22400.8.camel@localhost>
	 <1053449334.7780.25.camel@serpentine.internal.keyresearch.com>
	 <Pine.LNX.4.53.0305201312270.5930@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1053455998.7780.35.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 May 2003 11:39:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-20 at 10:19, Richard B. Johnson wrote:

> Isn't it that there are 'helper' functions in the kernel that are
> not needed and a user-space DHCP server already works and is
> available?

The original question was about an in-kernel DHCP client, which exists
in the form of net/ipv4/ipconfig.c.  The vague plan of record is to
remove it from the kernel some time early in the 2.6 era, and replace it
with a userspace ipconfig implementation that runs in initramfs.

Note the complete lack of mention of DHCP servers.

	<b

