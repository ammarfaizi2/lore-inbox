Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRFMOHK>; Wed, 13 Jun 2001 10:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263752AbRFMOHA>; Wed, 13 Jun 2001 10:07:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65189 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263674AbRFMOGw>;
	Wed, 13 Jun 2001 10:06:52 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.29554.888847.108615@pizda.ninka.net>
Date: Wed, 13 Jun 2001 07:06:42 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: <10072.992441032@ocs4.ocs-net>
In-Reply-To: <3B276F31.8BBF06AF@mandrakesoft.com>
	<10072.992441032@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > OTOH if any *.S code is compiled into a module then all symbols it
 > refers to must be EXPORT_SYMBOL_NOVERS().

Why not just add --include modversions.h to the gcc command line to
build it, why wouldn't this work?

Later,
David S. Miller
davem@redhat.com
