Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTBSVqT>; Wed, 19 Feb 2003 16:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTBSVqT>; Wed, 19 Feb 2003 16:46:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19651 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261894AbTBSVqS>;
	Wed, 19 Feb 2003 16:46:18 -0500
Date: Wed, 19 Feb 2003 13:39:06 -0800 (PST)
Message-Id: <20030219.133906.127189630.davem@redhat.com>
To: toml@us.ibm.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPSec protocol application order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF8FC87DCF.42F7A5C1-ON86256CD2.007686FA-86256CD2.0077C5EA@pok.ibm.com>
References: <OF8FC87DCF.42F7A5C1-ON86256CD2.007686FA-86256CD2.0077C5EA@pok.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Tom Lendacky" <toml@us.ibm.com>
   Date: Wed, 19 Feb 2003 15:48:14 -0600

   So if you would prefer to not do this in the kernel you can ignore
   the patch, but then the setkey application needs to be fixed.

In one sense yes, but in another no.

setkey is for manual keying and debugging.  Therefore, disallowing
experimenting with non-rfc-compliant orderings seems to lack purpose
to me.
