Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275318AbTHGNGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHGNGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:06:04 -0400
Received: from smtp03.web.de ([217.72.192.158]:14116 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S275318AbTHGNGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:06:01 -0400
From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Aug 2003 15:06:04 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: fcusack@fcusack.com, Luke Howard <lukeh@PADL.COM>
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <200308071506.04890.Mathias.Froehlich@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think you can try out the nss_ldap rpm at

http://na.uni-tuebingen.de/~frohlich/nss_ldap/

It is built on RedHat 9.
The main target of this rpm is to eliminate the recursive entrance bug of 
nss_ldap if the ldap host is not resolved before entering the ldap nss 
modules gethostbyname. But there is also some threading cleanup included.

I don't know what the real reason of the reported problem is, but it does not 
occur since the time i use my patched nss_ldap module.
I use both kinds of kernels with redhat 9 vanilla kernel.org and redhat 
modified ones.

 Hope this helps

    Mathias Fröhlich

-- 
Mathias Fröhlich, email: Mathias.Froehlich@web.de


