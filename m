Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283602AbRK3KyY>; Fri, 30 Nov 2001 05:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283601AbRK3KyO>; Fri, 30 Nov 2001 05:54:14 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:15635 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S283599AbRK3KyG> convert rfc822-to-8bit; Fri, 30 Nov 2001 05:54:06 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: dangelo.sasaman@tiscalinet.it, linux-kernel@vger.kernel.org
Subject: Re: strange network message
Date: Fri, 30 Nov 2001 11:52:37 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C076314.B639C5D4@tiscalinet.it>
In-Reply-To: <3C076314.B639C5D4@tiscalinet.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E169lIo-00030M-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to bring up the eth0 interface the following message appears:
>
>     Cannot open netlink socket: Address family not supported by protocol

You should activate CONFIG_NETLINK (Kernel/User netlink socket) and 
CONFIG_RTNETLINK (routing messages) in you kernel network options config.

greetings

Christian Bornträger
