Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUJBR2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUJBR2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJBRYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:24:54 -0400
Received: from cenn.mc.mpls.visi.com ([208.42.156.9]:12497 "EHLO
	cenn.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S267433AbUJBRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:23:04 -0400
Message-ID: <415EE33A.5030103@steinerpoint.com>
Date: Sat, 02 Oct 2004 12:19:54 -0500
From: Al Borchers <alborchers@steinerpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: new locking in change_termios breaks USB
 serial drivers
References: <415D3408.8070201@steinerpoint.com>	 <1096630567.21871.4.camel@localhost.localdomain>	 <415D84A3.6010105@steinerpoint.com>	 <1096645773.21958.54.camel@localhost.localdomain>	 <415D9E96.1030207@steinerpoint.com> <1096729712.25129.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-10-01 at 19:14, Al Borchers wrote:
>>* The tty layer could use a semaphore so the USB serial set_termios could
>>   sleep until the new termios settings have taken effect before returning.
> 
> This seems to be the right choice and is the change I will implement.

Great!  Thanks.

-- Al

