Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTILST6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTILST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:19:58 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:29202 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261826AbTILSS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:18:56 -0400
Message-ID: <3F621355.3050009@techsource.com>
Date: Fri, 12 Sep 2003 14:41:25 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Veraldi <luca.veraldi@katamail.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <20030910114414.B14352@devserv.devel.redhat.com> <01f801c37783$9ead8960$5aaf7450@wssupremo> <20030910121453.B9878@devserv.devel.redhat.com> <024601c37785$e3e07680$5aaf7450@wssupremo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Luca Veraldi wrote:

> 
> Sorry, but I cannot believe it.
> Reading a page tagle entry and storing in into a struct capability is not
> comparable at all with the "for" needed to move bytes all around memory.


Pardon my ignorance here, but the impression I get is that changing a 
page table entry is not as simple as just writing to a bit somewhere.  I 
suppose it is if the page descriptor is not loaded into the TLB, but if 
it is, then you have to ensure that the TLB entry matches the page 
table; this may not be a quick operation.

I can think of a lot of other possible complications to this.

