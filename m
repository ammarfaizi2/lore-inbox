Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275335AbTHGNUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275336AbTHGNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:20:37 -0400
Received: from au.padl.com ([203.13.32.1]:46602 "EHLO au.padl.com")
	by vger.kernel.org with ESMTP id S275335AbTHGNUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:20:32 -0400
From: Luke Howard <lukeh@PADL.COM>
Message-Id: <200308071320.XAA79071@au.padl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Organization: PADL Software Pty Ltd
To: Mathias.Froehlich@web.de
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
Cc: linux-kernel@vger.kernel.org, fcusack@fcusack.com
Reply-To: lukeh@PADL.COM
Date: Thu, 7 Aug 2003 23:20:21 +1000
Versions: dmail (bsd44) 2.4c/makemail 2.9d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Integrating this patch is on my todo list.

-- Luke

>From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>
>Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
>To: linux-kernel@vger.kernel.org
>Cc: fcusack@fcusack.com, Luke Howard <lukeh@padl.com>
>Date: Thu, 7 Aug 2003 15:06:04 +0200
>
>
>Hi,
>
>I think you can try out the nss_ldap rpm at
>
>http://na.uni-tuebingen.de/~frohlich/nss_ldap/
>
>It is built on RedHat 9.
>The main target of this rpm is to eliminate the recursive entrance bug of 
>nss_ldap if the ldap host is not resolved before entering the ldap nss 
>modules gethostbyname. But there is also some threading cleanup included.
>
>I don't know what the real reason of the reported problem is, but it does not 
>occur since the time i use my patched nss_ldap module.
>I use both kinds of kernels with redhat 9 vanilla kernel.org and redhat 
>modified ones.
>
> Hope this helps
>
>    Mathias Fröhlich
>
>-- 
>Mathias Fröhlich, email: Mathias.Froehlich@web.de
>
>

