Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUB0TvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbUB0TvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:51:14 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:23184 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263005AbUB0TvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:51:10 -0500
Message-ID: <403F9F9C.5090908@keyaccess.nl>
Date: Fri, 27 Feb 2004 20:50:52 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271420250.18958@logos.cnet> <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>>>>hdh: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
>>>>hdh: task_no_data_intr: error=0x04 { DriveStatusError }
>>>>hdh: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=2112/16/63

[ ... ]

> Received an unrecognised command from the kernel? What can cause that?

Still this one, it would appear:

http://www.ussg.iu.edu/hypermail/linux/kernel/0402.0/1421.html

Everyone running 2.4 (> .19 or so, the new IDE stuff) with an older 
drive is seeing this.

Rene.



