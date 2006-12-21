Return-Path: <linux-kernel-owner+w=401wt.eu-S1422967AbWLUQmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWLUQmJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422960AbWLUQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:42:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:39911 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422967AbWLUQmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=V9W5HbyUuMSNvthEG85UqSW2vr8Xio0tgTiuC+RNrGW/68DazV15v3WQmy+IuhAayCEP+CD5YCe+XGzi81h+9tltAKsuO1aXVQ9QlbFTJHL05uABZgvRWVHZPLtGy7E/DudDM0xaoOTuj+URT+0kCRr5x4uLG+IYL11zwLice3M=
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling
	mechanism.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
In-Reply-To: <20061221144644.GA4735@2ka.mipt.ru>
References: <11666924573643@2ka.mipt.ru> <20061221103539.GA4099@2ka.mipt.ru>
	 <458A64E5.4050703@garzik.org> <20061221104918.GA16744@2ka.mipt.ru>
	 <1166708885.3749.49.camel@localhost> <20061221140429.GA25214@2ka.mipt.ru>
	 <1166710867.3749.56.camel@localhost> <20061221142337.GA17204@2ka.mipt.ru>
	 <20061221143621.GA32706@2ka.mipt.ru> <1166712026.3749.60.camel@localhost>
	 <20061221144644.GA4735@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 11:42:04 -0500
Message-Id: <1166719324.3863.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-21-12 at 17:46 +0300, Evgeniy Polyakov wrote:
> On Thu, Dec 21, 2006 at 09:40:26AM -0500, jamal (hadi@cyberus.ca) wrote:
> > > Things like sockets/pipes can only benefit from direct kevent usage 
> > > instead of ->poll() and wrappers.
> > 
> > You should be able change it to use those schemes when it detects
> > that the kernel supports them.
> 
> I.e. stat() for each new file descriptor - note, that _you_ asked it :)

Didnt follow. Is there some issue with libevent you mean? 

cheers,
jamal


