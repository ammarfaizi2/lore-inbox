Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUB0SWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUB0SWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:22:47 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:25472 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262931AbUB0STt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:19:49 -0500
Date: Fri, 27 Feb 2004 18:20:31 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402271820.i1RIKVLb000744@81-2-122-30.bradfords.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Erik van Engelen <Info@vanE.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
References: <403F2178.70806@vanE.nl>
 <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hdh: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hdh: task_no_data_intr: error=0x04 { DriveStatusError }
> > hdh: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=2112/16/63
> 
> Haven't got a clue about these "status=0x51" and "error=0x04". Anyone?

Basically, the errors mean what they say - the drive is in an error
state, (received an unrecognised command), but is ready for further
operation.

John.
