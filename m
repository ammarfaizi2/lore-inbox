Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTE3K4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTE3K4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:56:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62168
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263578AbTE3K4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:56:48 -0400
Subject: Re: [CHECKER] pcmcia user-pointer dereference
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Junfeng Yang <yjf@stanford.edu>
In-Reply-To: <20030529143624.A10639@sonic.net>
References: <20030529142238.A8933@sonic.net>
	 <D43209EB-921C-11D7-B8B8-000A95A0560C@us.ibm.com>
	 <20030529143624.A10639@sonic.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054289503.23566.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 11:11:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 22:36, David Hinds wrote:
> The map_mem_page ioctl can only be used by root.  The get_*_window
> ioctl's can't corrupt anything because they, like get_mem_page, only
> read the target data structures.

Which if the passed address is something like a PCI DMA trigger register
isn't going to be too pretty

