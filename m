Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTEGGtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTEGGtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:49:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64749 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262932AbTEGGs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:48:56 -0400
Date: Tue, 06 May 2003 22:53:42 -0700 (PDT)
Message-Id: <20030506.225342.68058619.davem@redhat.com>
To: thomas@horsten.com
Cc: hch@infradead.org, voidcartman@yahoo.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305070759.49121.thomas@horsten.com>
References: <200305070744.27207.thomas@horsten.com>
	<20030507074557.A9197@infradead.org>
	<200305070759.49121.thomas@horsten.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Horsten <thomas@horsten.com>
   Date: Wed, 7 May 2003 07:59:49 +0100

   On Wednesday 07 May 2003 7:45 am, Christoph Hellwig wrote:
   > That's highly broken because his libc was compiled against 2.2 headers.
   > You must never use different headers in /usr/include/Pasm,linux}
   > then those your libc was compiled against.
   
   I don't see why moving up should be wrong -

The headers used for 2.2.x era libc cannot cope with or conflit with
many of the constructs used by current kernel headers.

Chritoph's points are very real.
