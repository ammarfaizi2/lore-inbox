Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268395AbTBNNkY>; Fri, 14 Feb 2003 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268396AbTBNNkY>; Fri, 14 Feb 2003 08:40:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10882
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268395AbTBNNkW>; Fri, 14 Feb 2003 08:40:22 -0500
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0302141431430.1173-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0302141431430.1173-100000@pcgl.dsa-ac.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045234221.7958.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 14:50:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 13:36, Guennadi Liakhovetski wrote:
> > For some reason we decided the drive support cache flush. However it
> > apparently doesnt
> 
> The last of the above errors does not appear on SanDisk - it supports
> cache flush?

Could be. Or could be the other flash disk claims to support it but
does not. You'd want to check the identify data for the disk to see
what commands it claims support for


