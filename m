Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSIJUHV>; Tue, 10 Sep 2002 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSIJUHV>; Tue, 10 Sep 2002 16:07:21 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:55283
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317673AbSIJUHU>; Tue, 10 Sep 2002 16:07:20 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Mares <mj@ucw.cz>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020910184128.GA5627@ucw.cz>
References: <20020910134708.GA7836@bytesex.org>
	<20020910163023.GA3862@ucw.cz>
	<1031683362.1537.104.camel@irongate.swansea.linux.org.uk> 
	<20020910184128.GA5627@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 21:15:12 +0100
Message-Id: <1031688912.31787.129.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 19:41, Martin Mares wrote:
> > pci_driver has no implicit ordering.
> 
> Agreed, but I meant inserting it as a module before the other
> modules.

Which breaks the moment it meets a hotplug system

