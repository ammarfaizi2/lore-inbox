Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424842AbWKQUbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424842AbWKQUbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933681AbWKQUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:31:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20116 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933736AbWKQUbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:31:31 -0500
Message-ID: <455E1C22.1090108@garzik.org>
Date: Fri, 17 Nov 2006 15:31:30 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Felix Marti <felix@chelsio.com>
CC: linux-kernel@vger.kernel.org, Netdev List <netdev@vger.kernel.org>
Subject: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
References: <8A71B368A89016469F72CD08050AD334DA4851@maui.asicdesigners.com> <455E1C01.8000603@garzik.org>
In-Reply-To: <455E1C01.8000603@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Felix Marti wrote:
>> Jeff, as indicated by Chris, the driver that is in the kernel is for
>> N110 and N210. So far, we have not received any customer complaints
>> regarding bugs in the driver and thus it has not been updated in a long
>> time. If you feel like there are some missing features/bug fixes, I'd be
>> glad to spend some time on it.
>>
>> However, Chris's initial request is regarding support for T210. As you
>> indicate, the T210 product is a superset of N110/N210 and i.e. supports
>> TOE. Since the T210 board features additional pieces of hardware, these
>> must be initialized (i.e. memory controllers and TCAM) even if the board
>> is to be used as a NIC only. If the kernel developers are okay with
>> these additional initialization procedures we could update the driver to
>> support N as well as T based products, in NIC mode only, of course ;)
> 
> 
> I'd welcome support for NIC mode, so, sure...

Well, presuming that active maintenance comes along with it...

	Jeff


