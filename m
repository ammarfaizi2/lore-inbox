Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVKUIqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVKUIqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKUIqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:46:51 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:52924 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932232AbVKUIqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:46:50 -0500
Message-ID: <43818970.80408@shadowconnect.com>
Date: Mon, 21 Nov 2005 09:46:40 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com> <20051120225256.GC27946@ftp.linux.org.uk> <20051120230714.GD27946@ftp.linux.org.uk> <20051120232158.GE27946@ftp.linux.org.uk> <4381194A.3080609@shadowconnect.com> <20051121033850.GG27946@ftp.linux.org.uk>
In-Reply-To: <20051121033850.GG27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Al Viro wrote:
> On Mon, Nov 21, 2005 at 01:48:10AM +0100, Markus Lidel wrote:
>>memcpy_fromio(&evt->body[1], &msg->body[1], size * 4);
>                 evt->data, surely?

Hehehe, probably i should first try to compile it before replying :-) But 
better late then never :-)

Here the proper line:

   memcpy(&evt->data, &msg->body[1], size * 4);

Thanks for you help!



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
