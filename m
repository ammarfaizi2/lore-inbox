Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273836AbRJIJYE>; Tue, 9 Oct 2001 05:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273846AbRJIJXz>; Tue, 9 Oct 2001 05:23:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59532 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273836AbRJIJXm>;
	Tue, 9 Oct 2001 05:23:42 -0400
Date: Tue, 09 Oct 2001 02:24:05 -0700 (PDT)
Message-Id: <20011009.022405.77061246.davem@redhat.com>
To: panto@intracom.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC2A65F.67B7D415@intracom.gr>
In-Reply-To: <3BC1735F.41CBF5C1@intracom.gr>
	<20011008.024946.74749362.davem@redhat.com>
	<3BC2A65F.67B7D415@intracom.gr>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pantelis Antoniou <panto@intracom.gr>
   Date: Tue, 09 Oct 2001 10:25:19 +0300

   I've look at your script and it kinda flew over my head.
   
   Would you mind explain this a bit?

We generate the offsets as data items in an assembler file, then we
parse out those data section entries and spit them into the header.

It allows cross compilation setups to work, ie. even in cases when you
cannot generate and run a binary.

Franks a lot,
David S. Miller
davem@redhat.com
