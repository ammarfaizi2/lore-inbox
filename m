Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKTV2n>; Tue, 20 Nov 2001 16:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKTV2d>; Tue, 20 Nov 2001 16:28:33 -0500
Received: from t2.redhat.com ([199.183.24.243]:25335 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280911AbRKTV2X>; Tue, 20 Nov 2001 16:28:23 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011120190316.H19738@vnl.com> 
In-Reply-To: <20011120190316.H19738@vnl.com> 
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 21:27:37 +0000
Message-ID: <2048.1006291657@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


amon@vnl.com said:
> In any case, here is the problem:
> 	NIC on motherboard, Realtek
> 	NIC on PCI card, Realtek
> 	Monolithic (no-module) kernel
> 	Motherboard must be set to eth0 

Why must the motherboard be set to eth0? Why not just configure it as it 
gets detected?

If you really care about the names, there's an ioctl you can use to change 
them. You can call them 'fred' and 'sheila' if you so desire.


--
dwmw2


