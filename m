Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWEKUSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWEKUSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWEKUSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:18:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14531 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750761AbWEKUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:18:29 -0400
Subject: Re: [PATCH -mm] updated idetape gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147367677.26087.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <200605101810.k4AIAA8x006488@dwalker1.mvista.com>
	 <1147353102.26130.6.camel@localhost.localdomain>
	 <1147367677.26087.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 21:30:41 +0100
Message-Id: <1147379442.26130.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 10:14 -0700, Daniel Walker wrote:
> So it should try to write something even on an error ? It looks like it
> would be really difficult to drop the data off the BHs without actually
> doing the write .. The most straight forward way to handle the error
> would be write all the data copied ..

copy_from_user zero fills failure space so that bit is an accounting job
only. 
