Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUE2Uo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUE2Uo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUE2Uo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:44:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264113AbUE2Uo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:44:57 -0400
Date: Sat, 29 May 2004 21:44:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
Message-ID: <20040529204457.GI12308@parcelfarce.linux.theplanet.co.uk>
References: <40B8D2F8.6090905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B8D2F8.6090905@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 02:14:16PM -0400, Jeff Garzik wrote:
 
> I'm a bit curious why sparse complained about taking the _address_ of 
> pointer, but nonetheless it's an ugliness that should be contained 
> before it spreads :)  Attached is a proposed cleanup patch for comment. 
>  The ugliness is confined to include/linux/mii.h, and I avoid use the 
> ifru_data field completely.

sparse hadn't ;-)  I had, when I saw it in grep output.
