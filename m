Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSG3Vn4>; Tue, 30 Jul 2002 17:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSG3Vne>; Tue, 30 Jul 2002 17:43:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316684AbSG3VmL>;
	Tue, 30 Jul 2002 17:42:11 -0400
Message-ID: <3D4708FD.7040002@mandrakesoft.com>
Date: Tue, 30 Jul 2002 17:45:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730210938.GA16657@kroah.com>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
>>-	__u16 bustype;
>>-	__u16 vendor;
>>-	__u16 product;
>>-	__u16 version;
>>+	uint16_t bustype;
>>+	uint16_t vendor;
>>+	uint16_t product;
>>+	uint16_t version;
> 
> 
> {sigh}  __u16 is _so_ much nicer, and tells the programmer, "Yes I know
> this variable needs to be the same size in userspace and in
> kernelspace."


Agreed, but u16 is even better :)  Why use the '__' prefix when standard 
kernel types do not need them?

	Jeff



