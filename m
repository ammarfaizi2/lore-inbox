Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSI3M1a>; Mon, 30 Sep 2002 08:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbSI3M1a>; Mon, 30 Sep 2002 08:27:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47024 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262036AbSI3M1a>;
	Mon, 30 Sep 2002 08:27:30 -0400
Date: Mon, 30 Sep 2002 05:25:55 -0700 (PDT)
Message-Id: <20020930.052555.123500588.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: bunk@fs.tum.de, jochen@scram.de, linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 compile errors on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033389340.16337.14.camel@irongate.swansea.linux.org.uk>
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
	<1033389340.16337.14.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 30 Sep 2002 13:35:40 +0100

   Is this actually safe - suppose the machine has no tsc counter (eg old
   x86 or indeed new x86 numa, speedstep using, etc). In that case
   do_gettimeofday doesn't appear to be either IRQ safe or fast enough to
   use in this way ?

This is how netif_rx() has worked for a long time.  ATM is just
copying the input packet logic.

So why are you complaining now? :-)
