Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRKTVuG>; Tue, 20 Nov 2001 16:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281288AbRKTVt5>; Tue, 20 Nov 2001 16:49:57 -0500
Received: from t2.redhat.com ([199.183.24.243]:36855 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281075AbRKTVtw>; Tue, 20 Nov 2001 16:49:52 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011120212055.A22590@vnl.com> 
In-Reply-To: <20011120212055.A22590@vnl.com>  <20011120190316.H19738@vnl.com> <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com> 
To: Dale Amon <amon@vnl.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 21:49:01 +0000
Message-ID: <2722.1006292941@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


amon@vnl.com said:
>  I haven't really much choice. I can't use modules for security
> reasons; I have to assign the motherboard MAC to eth0 because a
> commercial package we are installing licenses on the MAC address of
> eth0.  

insmod dummy
ip link set dummy0 name eth0
ip link set eth0 address 01:02:03:04:05:06

Of course, if you're not in the Free World you may end up in prison for 
doing that.

--
dwmw2


