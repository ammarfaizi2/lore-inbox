Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWDXXt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWDXXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWDXXt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:49:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32077 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932124AbWDXXt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:49:27 -0400
Date: Mon, 24 Apr 2006 17:48:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Van Jacobson's net channels and real-time
In-reply-to: <65cJF-66i-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <444D63D9.8060804@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <63KcN-6lD-25@gated-at.bofh.it> <64wrg-2cg-41@gated-at.bofh.it>
 <64wAE-2Cs-9@gated-at.bofh.it> <64AkV-8cG-7@gated-at.bofh.it>
 <65cqo-5tR-33@gated-at.bofh.it> <65cJF-66i-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Message signaled interrupts are just a kudge to save a trace on a
> PC board (read make junk cheaper still). They are not faster and
> may even be slower.

Save a trace on the PC board? How about no, since the devices still need 
to support INTX interrupts anyway. And yes, they can be faster, mainly 
because being an in-band signal it simplifies some PCI posting related 
issues, and there is no need to worry about sharing.

 > They will not be the salvation of any interrupt
> latency problems. The solutions for increasing networking speed,
> where the bit-rate on the wire gets close to the bit-rate on the
> bus, is to put more and more of the networking code inside the
> network board. The CPU get interrupted after most things (like
> network handshakes) are complete.

You mean like these?

http://linux-net.osdl.org/index.php/TOE

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

