Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbTICQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbTICQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:53:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264100AbTICQxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:53:24 -0400
Message-ID: <3F561BE4.7090806@pobox.com>
Date: Wed, 03 Sep 2003 12:50:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcel Holtmann <marcel@holtmann.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: request_firmware() backport to 2.4
References: <20030902192043.GD22376@bougret.hpl.hp.com>
In-Reply-To: <20030902192043.GD22376@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> Marcelo wrote :
> 
>>On 1 Sep 2003, Marcel Holtmann wrote:
>>
>>
>>>no, the bfubase.frm is the original firmware file from AVM. This file
>>>have to be placed somewhere on the filesystem. 
>>
>>Right, and without placing the file somewhere on the filesystem bfusb
>>2.4.22 users wont have 2.4.23 working without "issues".
> 
> 
> 	But various high level kernel people, such as Jeff, have
> decided that binary firmwares *must* be removed from the kernel
> because of legal "issues" (GPL == source available). In 2.6.X, it
> seems that the tolerance towards this "issue" will end, so all those
> nasty details will have to work.

Well, I wouldn't put it that strongly.

It's more like, at least in my own case, the Debian people make a stink 
about the legality of non-GPL'd firmwares.  And certain people, and at 
certain times, have refused patches related to legality of firmwares. 
AND, on top of all that, as a programmer I hate seeing these ugly BLOBs 
embedded in C code, and would much rather see them removed from the C 
source code.

So, I "prefer" that firmware leaves the kernel, but that's just my 
personal opinion.  There has been no decision made AFAIK, and I don't 
recall Marcelo or Linus speaking definitively on the subject.


> 	Of course, 2.4.X is more "don't rock the boat".

Agreed...

	Jeff



