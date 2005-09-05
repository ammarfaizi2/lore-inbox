Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVIEBab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVIEBab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 21:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIEBab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 21:30:31 -0400
Received: from web50211.mail.yahoo.com ([206.190.39.175]:4798 "HELO
	web50211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932122AbVIEBab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 21:30:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VW28igJ4IIjDr1zV7R3tQRRJP8e7LBdtjPF2Qd9czXKGSU7avZPQ6AmfVnq3PGYSrctl3+3J4d9nQ74srR+Nm7nFRXfnSDRsA1n9TnWtuLlWYHG0vFUB5wZ1g68USrad9xsfpopB/YHZMV/stAsmBdvK2qL/WLQIakOqsd0C02Y=  ;
Message-ID: <20050905013030.14361.qmail@web50211.mail.yahoo.com>
Date: Sun, 4 Sep 2005 18:30:29 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The NdisWrapper FAQ already tells you that you need a patch for some of 
>the binary-only Windows drivers that require more than 8kB stacks.
>
>And the fact that NdisWrapper is mostly working hinders the development 
>of open source drivers for this hardware.

If the hardware manufacturer won't give you the spec's then writing a driver
is going to be pretty difficult, if not impossible. Reverse-engineering 
may be possible, but still....

I believe it's the lack of spec's, rather than the existence of ndiswrapper
and driverloader, that hinder driver development. 

-Alex




I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
