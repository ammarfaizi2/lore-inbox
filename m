Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSBZXeU>; Tue, 26 Feb 2002 18:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBZXeK>; Tue, 26 Feb 2002 18:34:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289089AbSBZXdu>;
	Tue, 26 Feb 2002 18:33:50 -0500
Message-ID: <3C7C1B07.92F9B8E0@zip.com.au>
Date: Tue, 26 Feb 2002 15:32:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org> <3C7BD91C.3B758704@zip.com.au> <20020226185907.GG803@ufies.org>,
		<20020226185907.GG803@ufies.org> <20020226230010.GI803@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> Now that the forget_option bug is solved I have the following :
> 
> Each time I suspend, the card resume in a bad state but return in a good
> state after that :
> 
> NETDEV WATCHDOG: eth0: transmit timed out

The transceiver didn't power up, or came up in silly
mode.  I'll see if I can reproduce any of this.
What NIC are you using?

-
