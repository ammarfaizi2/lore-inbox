Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276977AbRJQQsJ>; Wed, 17 Oct 2001 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRJQQr7>; Wed, 17 Oct 2001 12:47:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10368 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276977AbRJQQrz>;
	Wed, 17 Oct 2001 12:47:55 -0400
Date: Wed, 17 Oct 2001 09:48:22 -0700 (PDT)
Message-Id: <20011017.094822.85411855.davem@redhat.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.14prex and qlogicfc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BCDB039.8F00D818@redhat.com>
In-Reply-To: <20011017081837.C3035@suse.de>
	<20011016.233534.48799017.davem@redhat.com>
	<3BCDB039.8F00D818@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arjan van de Ven <arjanv@redhat.com>
   Date: Wed, 17 Oct 2001 17:22:17 +0100

   "David S. Miller" wrote:
   > Not if it broke in pre1 since the pci64 stuff went into pre2 :-)
   
   since it broke as of pre2, the following things are suspect:
   
Wrong qlogic driver arjan :-)  There never was ever a reference
to virt_to_bus anything in the qlogicfc driver since early 2.3.x
days when the PCI DMA api first went into the tree.

Franks a lot,
David S. Miller
davem@redhat.com
