Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAMW4n>; Sat, 13 Jan 2001 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRAMW4e>; Sat, 13 Jan 2001 17:56:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35990 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129562AbRAMW43>;
	Sat, 13 Jan 2001 17:56:29 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14944.56558.198555.536993@pizda.ninka.net>
Date: Sat, 13 Jan 2001 14:55:42 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 compile fix
In-Reply-To: <20010113152104.B2734@ppetru.net>
In-Reply-To: <20010113152104.B2734@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > -       struct dqblk d;
 > +       struct dqblk32 d;

What does this fix?  Things compile just fine without
it and looking at the code it was intended to be of
the original type.

Please explain exactly what submitted patches fix in
the future, thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
