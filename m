Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTBHI5P>; Sat, 8 Feb 2003 03:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTBHI5P>; Sat, 8 Feb 2003 03:57:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266977AbTBHI5O>;
	Sat, 8 Feb 2003 03:57:14 -0500
Date: Sat, 08 Feb 2003 00:53:03 -0800 (PST)
Message-Id: <20030208.005303.80023391.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: christopher.leech@intel.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: skb_padto and small fragmented transmits
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1044624820.14026.7.camel@irongate.swansea.linux.org.uk>
References: <1044559328.4618.54.camel@localhost.localdomain>
	<20030206.144306.14966745.davem@redhat.com>
	<1044624820.14026.7.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 07 Feb 2003 13:33:41 +0000

   On Thu, 2003-02-06 at 22:43, David S. Miller wrote:
   > Indeed, Alan you need to fix the skb_padto stuff to use
   > skb->len, ignore the skb->data_len as skb->len is the
   > full length.
   
   Dave just fix it next time you touch the code and push it to Marcelo. It
   doesnt affect the 2.2 backport so that will be ok
   
Ok, I will take care of this.
