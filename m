Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTFHXFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTFHXFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:05:10 -0400
Received: from soapstone.yuri.org.uk ([193.201.200.157]:21645 "EHLO
	soapstone.yuri.org.uk") by vger.kernel.org with ESMTP
	id S263944AbTFHXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:05:05 -0400
Date: Mon, 9 Jun 2003 00:18:35 +0100
From: bill-linuxkernel20030609@boughton.org.uk
To: linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608231835.GA14026@yuri.org.uk>
References: <000501c32e00$85d4f670$8200a8c0@coolermaster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c32e00$85d4f670$8200a8c0@coolermaster>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19 i686
X-Date: Today is Prickle-Prickle, the 13rd day of Confusion in the YOLD 3169
X-Scanner: exiscan *19P9Qp-0003xZ-00*Uu/jT3Am6Tk* (The Yuri Organisation, London, United Kingdom of Great Britain and Northern Ireland)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 09:57:04PM +0100, Peter Westwood wrote:
> Hi All,
> 
> In a similar vein to the Linksys router.  I have a Buffalo (Melco) WBR-G54.
> 
> Looking through the latest firmware update available :
> http://www.buffalo-technology.com/support/firmware.htm
> 

I grabbed the wbr-113b.exe, lha x ed it
and found a cramfs image 2 bytes further on in the file than
with the linksys firmware.

lha x wbr-113.exe

dd if=wbrbg-113b of=test.dump skip=853 bs=922c

You now have a mountable cramfs which seems to include quite a bit of GPLed free 
software at a glance Zebra, fwlogwatch, busybox, dnrd, udhcpd, ntpclient.


-- 
William Boughton
