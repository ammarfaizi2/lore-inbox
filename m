Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313485AbSC2R2J>; Fri, 29 Mar 2002 12:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313486AbSC2R2A>; Fri, 29 Mar 2002 12:28:00 -0500
Received: from [65.201.154.134] ([65.201.154.134]:19948 "EHLO
	EXCHANGE01.domain.ecutel.com") by vger.kernel.org with ESMTP
	id <S313485AbSC2R1u> convert rfc822-to-8bit; Fri, 29 Mar 2002 12:27:50 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: kernel notification to user space task
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 29 Mar 2002 12:27:28 -0500
Message-ID: <AF2378CBE7016247BC0FD5261F1EEB210B6AA5@EXCHANGE01.domain.ecutel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel notification to user space task
Thread-Index: AcHXRcaF0jjxX4QSTrOnb1tLEG44igAAcOZw
From: "Hari Gadi" <HGadi@ecutel.com>
To: "Amol Kumar Lad" <amolk@ishoni.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
You can use signals like the example in the book rubini (see the asynchronous notification section).
http://www.xml.com/ldd/chapter/book/index.html

Be sure to download the examples (especially the "scull" example).
thanks,
Hari.

-----Original Message-----
From: Amol Kumar Lad [mailto:amolk@ishoni.com]
Sent: Friday, March 29, 2002 12:20 PM
To: 'linux-kernel@vger.kernel.org'
Subject: kernel notification to user space task


Hi,
  I have a user task running ...
I want my driver running in kernel to send a notification to this task when
it detects some event.

for example..if my driver detects that interface 'eth0' is coming up, it
should send a indication to user task saying 'network interface eth0 is up'

please cc me..

thanks
Amol

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
