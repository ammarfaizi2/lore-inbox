Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVK1VIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVK1VIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVK1VIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:08:21 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:32516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751309AbVK1VIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:08:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=BK9n2K5/1Ujxw2VHOLZi0lmwbJIHXV7nJC2Z4i//zSXTqkO95nddY/OGNcK2Jlz08EkQKbsoPvZf0mljuT34jrWYyvxZfOVhb31qUNAy4O9IyRywIniWs/9S7YE/vUdkuPl3PexmD1+57n+W66zqwfySrVsly7qKRRUA0ReCbGw=
Date: Mon, 28 Nov 2005 22:08:11 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <527051512.20051128220811@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re[4]: net_device + pci_dev question
In-Reply-To: <1133211819.2824.82.camel@laptopd505.fenrus.org>
References: <2510370984.20051127205827@gmail.com>
 <1133126713.2853.45.camel@laptopd505.fenrus.org>
 <1653628458.20051128215644@gmail.com>
 <1133211819.2824.82.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,

On 28th november 2005 (22:03:38) you wrote:

> oh it's *your own* netdev...

Yes:-) Sorry for not being precise

> that makes things a lot easier ;)


> it's custom to have driver private data per net dev
> (see netdev_priv() to get it, alloc_etherdev() takes the size of it as
> argument). It's custom to make that private data a struct in which you
> can store the pci device pointer yourself, as well as any other per card
> data that you need to store


Ok, I will do it like that then. Thank you for the explanation on this
issue.

kind regards,
Mateusz Berezecki

