Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbTCNNOQ>; Fri, 14 Mar 2003 08:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCNNOQ>; Fri, 14 Mar 2003 08:14:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11730
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263078AbTCNNOQ> convert rfc822-to-8bit; Fri, 14 Mar 2003 08:14:16 -0500
Subject: Re: Problems with ide-default.c and my hdd (2.5.64-ac3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mauricio =?ISO-8859-1?Q?Nu=F1ez?= <mauricio@chile.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303132203.53524.mauricio@chile.com>
References: <200303132203.53524.mauricio@chile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1047652417.27699.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 14:33:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 02:03, Mauricio Nuñez wrote:
> Hi
> 
> I'm booting 2.5.64-ac3 with hdd=none because I got a Kernel Panic default 
> attach failed.
> 
> With 2.4 not problems. What feedback can i send to you?

It appears some drivers are registering empty device slots. Thats
harmless with the old code, and not allowed with the new. I'm still
investigating

