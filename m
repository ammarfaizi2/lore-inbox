Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136130AbRAZQ2M>; Fri, 26 Jan 2001 11:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136120AbRAZQ2D>; Fri, 26 Jan 2001 11:28:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15507 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136059AbRAZQ1y>;
	Fri, 26 Jan 2001 11:27:54 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.42315.441894.892277@pizda.ninka.net>
Date: Fri, 26 Jan 2001 08:26:51 -0800 (PST)
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Odd network trace... 
In-Reply-To: <200101261621.RAA19330@cave.bitwizard.nl>
In-Reply-To: <200101261621.RAA19330@cave.bitwizard.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rogier Wolff writes:
 > Am I missing something?
 ...
 > 17:05:59.961324 server.http > client.1880: . 1:1(0) ack 287912 win 0 <nop,nop,timestamp 2800084 363441235> (DF)

server advertises zero window, no data may be sent.

Until server advertises a non-zero window, the data transfer
may not proceed.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
