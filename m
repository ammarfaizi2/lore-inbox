Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312207AbSCRGXI>; Mon, 18 Mar 2002 01:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312208AbSCRGW6>; Mon, 18 Mar 2002 01:22:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54459 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312207AbSCRGWq>;
	Mon, 18 Mar 2002 01:22:46 -0500
Date: Sun, 17 Mar 2002 22:19:23 -0800 (PST)
Message-Id: <20020317.221923.118544685.davem@redhat.com>
To: mfedyk@matchmail.com
Cc: alan@lxorguk.ukuu.org.uk, davids@webmaster.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020318050618.GC2254@matchmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mike Fedyk <mfedyk@matchmail.com>
   Date: Sun, 17 Mar 2002 21:06:18 -0800
   
   ... You'd have to use netfilter to mark the correct packets, then route on
   that mark to the dummy interface.
   
   How is that more efficient?
   
You can bind sockets to specific devices under Linux, this does not
require netfilter.
