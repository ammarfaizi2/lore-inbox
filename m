Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTEAXRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbTEAXRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:17:43 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:47423
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262780AbTEAXRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:17:42 -0400
Message-ID: <3EB1ADEC.6080007@rogers.com>
Date: Thu, 01 May 2003 19:29:48 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com> <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 19:30:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>
>The ne2000 ordering with the other ISA stuff in space.c is really
>sensitive for older systems. If you get ne2k too early it breaks some
>other cards if it autoprobes, if you get it too late it lets other
>stuff crash the box.
>
>So you might want to keep to Space.c for non pnp stuff if non modular
>  
>
Yeah, patches 1 and 2 do just this.

Are we stuck with Space.c forever? Anyone have any plans for replacing 
it with something more driver-model friendly?

-Jeff

