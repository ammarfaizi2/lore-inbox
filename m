Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265988AbSKDNAc>; Mon, 4 Nov 2002 08:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265640AbSKDNAc>; Mon, 4 Nov 2002 08:00:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8576 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262510AbSKDNAb>;
	Mon, 4 Nov 2002 08:00:31 -0500
Date: Mon, 04 Nov 2002 05:59:51 -0800 (PST)
Message-Id: <20021104.055951.41634255.davem@redhat.com>
To: benoit-lists@fb12.de
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] tcp hang solved
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021104123824.A29797@turing.fb12.de>
References: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl>
	<20021104.023620.20862097.davem@redhat.com>
	<20021104123824.A29797@turing.fb12.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Benoit <benoit-lists@fb12.de>
   Date: Mon, 4 Nov 2002 12:38:25 +0100
   
   This bug was introduced in 2.5.43-bk1, previous versions are ok.
   I think it might be 
   ChangeSet 1.781.1.68 2002/10/15 19:01:33 kuznet@mops.inr.ac.ru
   but i'm not sure.

It's not possible, if this functions modified here did not work you
would not be able to make any connections at all.

Can you try reverting the networking changesets one by one until
the problem goes away?

