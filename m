Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTDXEjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTDXEi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:38:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:11241 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264398AbTDXEix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:38:53 -0400
Subject: Re: [RESEND][PATCH] net/ipv6/netfilter warnings removal
From: "David S. Miller" <davem@redhat.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       netfilter-devel@lists.netfilter.org
In-Reply-To: <Pine.LNX.4.51.0304231434540.4838@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0304051607310.32140@dns.toxicfilms.tv>
	 <Pine.LNX.4.51.0304072115010.19830@dns.toxicfilms.tv>
	 <Pine.LNX.4.51.0304231434540.4838@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051159844.18160.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 21:50:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 05:38, Maciej Soltysiak wrote:
> And here is the patch to remove those by using casts.

It's kind of rediculious that these modules don't use the
existing AH/ESP/etc. header structure types (ip_auth_header et
al.)

That's why I'm not applying this patch, please fix all of these
modules up to use the same header structures as the IPSEC layer
does.  Then I'll take the patch.

Thanks.

> -- 
> David S. Miller <davem@redhat.com>
