Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbUANJDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUANJDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:03:00 -0500
Received: from [212.28.208.94] ([212.28.208.94]:36364 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265567AbUANJC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:02:56 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Subject: Re: USB timeout  Canon Powsrshot S30
Date: Wed, 14 Jan 2004 10:02:53 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200401061927.00833.roro.l@dewire.com> <20040113095132.A6697@beaverton.ibm.com>
In-Reply-To: <20040113095132.A6697@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141002.53984.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tisdagen den 13 januari 2004 18.51 skrev Patrick Mansfield:
> Are you using gphoto2? It passes down the timeout value to the kernel, try
> changing the timeout there.

Couldn't find a timeout setting, but I tried the --debug option which gives this

4.327410 canon/usb.c(2): canon_usb_long_dialogue: ERROR: Packet of size 10714682 is too big (max reasonable size specified is 10485760)
4.327876 canon/usb.c(2): canon_usb_get_file: canon_usb_long_dialogue() returned error (-102).
4.328175 canon/library.c(2): get_file_func: getting image data failed, returned -102
4.328444 libgphoto2/gphoto2-filesys.c(2): Download of 'MVI_1601.AVI' from '/DCIM/116CANON' (type 1) failed. Reason: 'Corrupted data'
4.328757 gphoto2-camera(2): Operation failed!
***  Fel  (-102: 'Corrupted data') ***

Which probably sends me off to another list.

The timeout message in the usb log is quite disinformative (if the message above is correct). 

But you did help me get further. Thanks.

-- robin

