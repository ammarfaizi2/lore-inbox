Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTCCPlH>; Mon, 3 Mar 2003 10:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTCCPlH>; Mon, 3 Mar 2003 10:41:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49563
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266308AbTCCPlG>; Mon, 3 Mar 2003 10:41:06 -0500
Subject: Re: [PATCH] cciss: add passthrough ioctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Stephen Cameron <steve.cameron@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303152706.C30584@devserv.devel.redhat.com>
References: <20030303032640.GA13102@zuul.cca.cpqcorp.net>
	 <20030303152706.C30584@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046710511.6530.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:55:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 15:27, Arjan van de Ven wrote:
> On Mon, Mar 03, 2003 at 09:26:40AM +0600, Stephen Cameron wrote:
> > Because, in order to flash the array controller firmware,
> > it's got to be done that way...
> 
> I don't buy this. Sorry. What's against creating a device for this
> controller itself ? 
> (And yes, the kernel could use a formal ioctl number for "upgrade firmware") 

All the other devices supporting firmware upgrade use ioctls for it. Its one
of those suitably obscure things where you don't care too much about the api
and you certainly don't want to get the wrong device!

