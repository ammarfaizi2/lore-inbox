Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLBPkh>; Mon, 2 Dec 2002 10:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSLBPkh>; Mon, 2 Dec 2002 10:40:37 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36510 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264624AbSLBPkh>; Mon, 2 Dec 2002 10:40:37 -0500
Subject: Re: oops loading aec62xx as module in 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Raptorfan <raptorfan@earthlink.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002301c29a17$53a59100$420aa8c0@beast>
References: <002301c29a17$53a59100$420aa8c0@beast>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 16:21:40 +0000
Message-Id: <1038846100.1000.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 15:27, Raptorfan wrote:
> Alan et al,
> 
> Pretty little fireworks when trying to load aec62xx as a module on a
> 2.4.20-ac1 kernel. Report is attached. Let me know if I can test anything
> for you. BTW, card is a SIIG CN-2487-based UDMA133 card.

Right now you can't insmod support for a chip that was already detected
by the legacy driver. For 2.4 I'll probably just kill modular support
for the chip drivers

