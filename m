Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQLDQdM>; Mon, 4 Dec 2000 11:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbQLDQdC>; Mon, 4 Dec 2000 11:33:02 -0500
Received: from isdn355.s.netic.de ([212.9.163.99]:2564 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S129724AbQLDQcx>;
	Mon, 4 Dec 2000 11:32:53 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.40.t11: Unresolved symbols while insmodding ip_tables.
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <3A2BABC7.98725631@windsormachine.com>
In-Reply-To: <E142Wt2-00031c-00@f5.mail.ru>
	<3A2BABC7.98725631@windsormachine.com>
X-Mailer: Mew version 1.94.2 on XEmacs 21.2 (Pan)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001204170118J.mccramer@s.netic.de>
Date: Mon, 04 Dec 2000 17:01:18 +0100
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I got problems using ip_tables.
 Insmodding ip_tables gives me:

 /lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_tables.o:
 unresolved symbol nf_unregister_sockopt
 /lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_tables.o:
 unresolved symbol nf_register_sockopt
 /lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_tables.o:
 insmod
 /lib/modules/2.4.0-test11/kernel/net/ipv4/netfilter/ip_tables.o fail

 I tried it with modutils 2.3.18 and the newest version 2.3.21, but
 both fail.

 The System.map does have these two symbols. netsyms.o does also
 have these symbols. Why haven't _I_ these symbols ;o)

 Any help very appreciated!

 Thank you very much in advance.

  keep hacking the right site of life ! :-)
  Meino  
   

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
