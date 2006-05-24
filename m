Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbWEXMd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWEXMd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWEXMd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:33:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26250 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932728AbWEXMd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:33:58 -0400
Subject: Re: OpenGL-based framebuffer concepts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xiong Jiang <linuster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9b5164430605231021h589dd194g8d88d46d1fcc4209@mail.gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <4472E3D8.9030403@garzik.org>
	 <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
	 <1148395433.25255.66.camel@localhost.localdomain>
	 <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com>
	 <1148403226.25255.89.camel@localhost.localdomain>
	 <9b5164430605231015s40ebcd38had1c3029da8afc7@mail.gmail.com>
	 <9b5164430605231021h589dd194g8d88d46d1fcc4209@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 May 2006 13:47:52 +0100
Message-Id: <1148474872.4753.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 10:21 -0700, Xiong Jiang wrote:
> What about initialization, mode and context switching? From the
> discussion I thought that people would like to see X server and
> framebuffer console could coexist in a more coordinated way, which
> could be coordinated DRI in kernel.


There has been some discussion of this in the past and it appears to
make a lot more sense. Really it needs bits of the driver model
reworking.

