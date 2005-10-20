Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVJTM30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVJTM30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 08:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVJTM30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 08:29:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:2784 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932094AbVJTM3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 08:29:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Hendry <ahendry@tusc.com.au>
Subject: Re: [PATCH] X25: Add ITU-T facilites
Date: Thu, 20 Oct 2005 14:30:15 +0200
User-Agent: KMail/1.7.2
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       eis@baty.hanse.de, linux-x25@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1129513666.3747.50.camel@localhost.localdomain> <Pine.LNX.4.61.0510181144320.28065@chaos.analogic.com> <1129770654.3574.1154.camel@localhost.localdomain>
In-Reply-To: <1129770654.3574.1154.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510201430.17160.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 20 Oktober 2005 03:10, Andrew Hendry wrote:
> __u32 or unsigned int look to be the norm for other similar headers,
> whats the recommended type of types to be used?
> 
Use __{u,s}{32,16,8} for interfaces and {u,s}{64,32,16,8} internally,
if you care about the exact size, otherwise use unsigned int.
See also http://lwn.net/Articles/113367/

	Arnd <><
