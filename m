Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbREUW6v>; Mon, 21 May 2001 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbREUW6m>; Mon, 21 May 2001 18:58:42 -0400
Received: from venus.Sun.COM ([192.9.25.5]:34522 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S262526AbREUW6b>;
	Mon, 21 May 2001 18:58:31 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <31cdf321e1.321e131cdf@mysun.com>
Date: Tue, 22 May 2001 00:49:48 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: SMC-IRCC broken? 2.4.5-pre4 / -ac5+
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> IRDA compiled in  ? If so is it ok modular . It sounds like yet 
> another boot
> ordering wonder

If I use it as a module it won't load
It says 'Device or resource busy'. (and yes i'm using the same io/irq
params as detected during bootup while compiled in).

That's why "half" of the irda subsys is compiled in. The protocol
code is modules.

