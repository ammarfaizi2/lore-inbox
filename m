Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSKKXrJ>; Mon, 11 Nov 2002 18:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSKKXrI>; Mon, 11 Nov 2002 18:47:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49829 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261615AbSKKXrI>; Mon, 11 Nov 2002 18:47:08 -0500
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: roland@topspin.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021111.153845.69968013.davem@redhat.com>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com> <52r8drn0jk.fsf_-_@topspin.com>
	 <20021111.153845.69968013.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 00:18:42 +0000
Message-Id: <1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 23:38, David S. Miller wrote:
> 
> So how are apps able to specify such larger hw addresses to configure
> a driver if IFHWADDRLEN is still 6?
> 
> I'm not going to increase MAX_ADDR_LEN if there is no user ABI capable
> of configuring such larger addresses properly.

The kernel just ignores it. We support multiple devices with larger
address lengths. Its mostly a legacy constant

