Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135489AbRECXvL>; Thu, 3 May 2001 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135494AbRECXvB>; Thu, 3 May 2001 19:51:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37253 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135489AbRECXut>;
	Thu, 3 May 2001 19:50:49 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.61128.43878.611369@pizda.ninka.net>
Date: Thu, 3 May 2001 16:50:32 -0700 (PDT)
To: Jim Freeman <jfree@sovereign.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iproute2, ETH_P_ECHO, linux/if_ether.h
In-Reply-To: <20010503164206.A19818@sovereign.org>
In-Reply-To: <20010503164206.A19818@sovereign.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim Freeman writes:
 > Documentation/Changes sez:
 > 
 > 	Ip-route2 
 > 	---------
 > 	o  <ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss991023.tar.gz>
 > 
 > 
 > But iproute2's lib/ll_proto.c  tries to use ETH_P_ECHO from
 > linux/if_ether.h, and that manifest constant has (recently ?)
 > been yanked?

Just remove the references to that ETH_P_ECHO constant in the
iproute2 sources.

Later,
David S. Miller
davem@redhat.com
