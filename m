Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264157AbRFLDTa>; Mon, 11 Jun 2001 23:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264167AbRFLDTT>; Mon, 11 Jun 2001 23:19:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40087 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264157AbRFLDTG>;
	Mon, 11 Jun 2001 23:19:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15141.35347.625434.930154@pizda.ninka.net>
Date: Mon, 11 Jun 2001 20:18:43 -0700 (PDT)
To: DJBARROW@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c
In-Reply-To: <C1256A68.0065E17F.00@d12mta09.de.ibm.com>
In-Reply-To: <C1256A68.0065E17F.00@d12mta09.de.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DJBARROW@de.ibm.com writes:
 > The dev->refcnt will go up to 2 ( it should be 1) unregister_netdevice will
 > usually  loop forever
 > waiting for the refcnt to drop to 1 when an attempt to unregister is done.

When will devices built statically into the kernel ever be
unregister'd?

Later,
David S. Miller
davem@redhat.com
