Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTEZCMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEZCMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:12:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22663 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263852AbTEZCMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:12:34 -0400
Date: Sun, 25 May 2003 19:25:12 -0700 (PDT)
Message-Id: <20030525.192512.88502097.davem@redhat.com>
To: torvalds@transmeta.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: netlink init order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
References: <20030525.190710.112599236.davem@redhat.com>
	<Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 25 May 2003 19:22:56 -0700 (PDT)

   
   On Sun, 25 May 2003, David S. Miller wrote:
   >    
   > That being said, you should be able to safely use module_init() there.
   
   Mind testing (and pushing back if ok) something like this, then?
   
I will, except I'll use module_init() and module_exit() instead
of __initcall and __exitcall.
