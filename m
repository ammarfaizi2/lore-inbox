Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTJTWRs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJTWRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:17:41 -0400
Received: from hermes.domdv.de ([193.102.202.1]:1803 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S262801AbTJTWRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:17:36 -0400
Message-ID: <3F945E35.7020708@domdv.de>
Date: Tue, 21 Oct 2003 00:14:13 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030711
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Donald Becker <becker@scyld.com>, linux-net@vger.kernel.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.22 and SMC EtherPower II 9432
References: <20031020205933.GS23191@fs.tum.de>
In-Reply-To: <20031020205933.GS23191@fs.tum.de>
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi,
> 
> on two different machines the ethernet card works with kernel 2.2.20 but 
> not with kernel 2.4.22 (both contain machines contain the same card).
> 
Just FYI:

I'm running more than 20 SMC9432TX and SMC9432BTX on 2.4.20 without 
problems. Output of one of these systems below.

admin@zeus:~ > /sbin/lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:08.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 09)
00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 08)
00:0a.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 08)
00:0b.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 08)
00:0c.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 08)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X 
(rev 65)
admin@zeus:~ > uname -a
Linux zeus 2.4.20 #2 Sat Sep 27 18:54:19 CEST 2003 i686 unknown

