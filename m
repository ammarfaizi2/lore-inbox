Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTFBUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTFBUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:25:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20200
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262390AbTFBUY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:24:28 -0400
Subject: Re: Documentation / code sample wanted.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jody Pearson <J.Pearson@cern.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
References: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054582801.7494.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 20:40:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-02 at 18:40, Jody Pearson wrote:
> I have looked over khttpd, which has been some help, and I looked briefly 
> at the nfs code, but I don't want to use RPC.
> 
> Can anybody point me to a document/code/patch to help me out ?
> 
> For more information, I basically want to emulate a userland 
> gethostbyname() in kernel space.

Thats basically impossible because gethostbyname will handle queries to
all kinds of things like LDAP or DNSSEC. Do your lookups in user space,
its a lot simpler.

