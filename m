Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSGYVdf>; Thu, 25 Jul 2002 17:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGYVdf>; Thu, 25 Jul 2002 17:33:35 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21234 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316535AbSGYVdf>; Thu, 25 Jul 2002 17:33:35 -0400
Subject: Re: modversion clarification.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pat Suwalski <pats@xandros.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D4024A3.6030401@xandros.com>
References: <3D4024A3.6030401@xandros.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 23:50:32 +0100
Message-Id: <1027637432.11669.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 17:17, Pat Suwalski wrote:
> According to several places in the 2.4.x documentation, it is the exact 
> opposite, and allows for large freedom to exchange modules between kernels.
> 
> Could someone please clarify for me?

It attempts to ensure you only load a module on a matching kernel. That
means stuff will sometimes load happily between versions which without
modversions it would not. It also mstly ensures you dont mistakenly load
a module from one 2.4.18 kernel into another binary incompatible one.
