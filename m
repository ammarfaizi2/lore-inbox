Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262969AbTC0Out>; Thu, 27 Mar 2003 09:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262993AbTC0Out>; Thu, 27 Mar 2003 09:50:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262969AbTC0Ous>;
	Thu, 27 Mar 2003 09:50:48 -0500
Date: Thu, 27 Mar 2003 06:59:11 -0800 (PST)
Message-Id: <20030327.065911.29350824.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: Obsolete messages ...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1048776371.2606.60.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
	<1048774874.19677.0.camel@rth.ninka.net>
	<1048776371.2606.60.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 27 Mar 2003 14:46:11 +0000

   In which case they would benefit from net/shut_up sysctl. In lots of
   environments they will just be a pain
   
Keep in mind we have these kinds of messages in 2.4.x right this
very moment, and nobody complains about them nor asks for sysctls
to shut them off.

See net/socket.c:sock_create() for example.

Now, I'll all for netratelimit()'ing the networking ones.
