Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFKGKA>; Mon, 11 Jun 2001 02:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRFKGJu>; Mon, 11 Jun 2001 02:09:50 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:37874 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263434AbRFKGJd>;
	Mon, 11 Jun 2001 02:09:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pekka Savola <pekkas@netcore.fi>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers 
In-Reply-To: Your message of "Mon, 11 Jun 2001 08:59:10 +0300."
             <Pine.LNX.4.33.0106110852570.23217-100000@netcore.fi> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Jun 2001 16:10:18 +1000
Message-ID: <12459.992239818@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001 08:59:10 +0300 (EEST), 
Pekka Savola <pekkas@netcore.fi> wrote:
>+MODULE_PARM_DESC(debug, "EPIC/100 debug level (0-5)");
>+MODULE_PARM_DESC(max_interrupt_work, "EPIC/100 maximum events handled per interrupt");
>I recall some discussion on a list (can't find it now) that driver
>specific comment like "EPIC/100" here notification on all _DESC's would be
>removed to a separate MODULE_ to make the comments more generic?

MODULE_DESCRIPTION("EPIC/100 some text") would be better.

