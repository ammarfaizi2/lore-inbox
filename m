Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270424AbTGRXVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270438AbTGRXVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:21:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49368
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270424AbTGRXVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:21:15 -0400
Subject: Re: [PATCH] (2.4.22-pre6 BK) new & changed (IDE) driver: SGI IOC4]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aniket Malatpure <aniket@sgi.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, alan@redhat.com,
       wildos@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <3F187E67.227651F@sgi.com>
References: <20030718020431.GA19018@taniwha.engr.sgi.com>
	 <3F187E67.227651F@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058571173.21085.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jul 2003 00:32:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-19 at 00:10, Aniket Malatpure wrote:
> Hi
> 
> This patch  (against the 2.4 BK tree as of yesterday evening) adds
> support for SGI IOC4 IDE driver as found in SN2/Altix systems
>  (http://sgi.com/altix for more details).
> 

Ok by me. There are sokme things that want dealing with but they affect
general paths so this is best for 2.4.22. I'll take a look at
abstracting the sglist format properly. SI3xxx also supports some
extended formats and could benefit.

