Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFCXET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTFCXET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:04:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16514
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261825AbTFCXER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:04:17 -0400
Subject: Re: siimage slow on 2.4.21-rc6-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mauk van der Laan <mauk.lists@maatwerk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDD25A0.1040602@maatwerk.net>
References: <3EDD1C87.5090906@maatwerk.net>
	 <1054675355.9233.73.camel@dhcp22.swansea.linux.org.uk>
	 <3EDD2260.20200@maatwerk.net>  <3EDD25A0.1040602@maatwerk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054678794.9233.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 23:19:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 23:48, Mauk van der Laan wrote:
> He! I just did
> 
> # hdparm -d1 -X66 /dev/hdX
> # echo "max_kb_per_request:15" > /proc/.ide/hdX/settings
> 
> on BOTH sata drives and everything works fine!
> Is it possible that they influence each other?

Not as I understand it, but this is rather useful information. The SI
does have some ties for PIO mode but not UDMA clocking. This is most
interesting information.

The max_kb_per thing should be irrelevant btw.

