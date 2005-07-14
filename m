Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVGNIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVGNIIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVGNIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 04:08:22 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:35550 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262962AbVGNIII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 04:08:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F4QNutG3F6LshaX9NkAxylW7opdiKPcWRIf4KfoWqgfoQOpS8fMZdZFo3qSNNGBsrwlJOHwWHhq4tNoPZs7wtyp0scx/HqZlx0orVDQElUL6lDccm4j6Q1SrQtdW/1V9vN3zJ0u8J1TyoiOPkGQz6UuE+Y9FrHNw3aHQJsiXb28=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marc Haber <mh+usenetspam200516@zugschlus.de>
Subject: Re: 2.6.12.2 tg3 driver doesn't ARP on 8021q 802.1q dot1q VLAN interfaces?
Date: Thu, 14 Jul 2005 12:15:11 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <dat3kv$rpq$1@sea.gmane.org>
In-Reply-To: <dat3kv$rpq$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507141215.11934.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 10:29, Marc Haber wrote:
> After rebooting, the VLANs on the Intel-based interfaces worked fine, while
> the tg3-based interfaces didn't answer to tagged ARP requests. The untagged
> VLAN on the tg3-based interfaces was fine as well. When tcpdumping the
> subinterfaces, I saw all traffic on the network, and especially the
> incoming ARP requests, but no ARP replies went out.

I've filed a bug at kernel bugzilla so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4883

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
