Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbRLSP6U>; Wed, 19 Dec 2001 10:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285339AbRLSP6L>; Wed, 19 Dec 2001 10:58:11 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:50838 "HELO smeg")
	by vger.kernel.org with SMTP id <S285338AbRLSP55>;
	Wed, 19 Dec 2001 10:57:57 -0500
Message-ID: <6524.193.132.197.81.1008777339.squirrel@mail.mswinxp.net>
Date: Wed, 19 Dec 2001 15:55:39 -0000 (GMT)
Subject: Re: IDE Harddrive Performance
From: "Lee Packham" <linux@mswinxp.net>
To: spike@superweb.ca
In-Reply-To: <01121911444703.31762@spikes>
In-Reply-To: <01121911444703.31762@spikes>
Cc: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno, just tried this on my box which has a 5400 RPM disk in and got 

[root@smeg lpackham]# /sbin/hdparm -t /dev/hdc

7200RPM on the on board
/dev/hdc:
 Timing buffered disk reads:  64 MB in  3.94 seconds = 16.24 MB/sec
[root@smeg lpackham]# /sbin/hdparm -t /dev/hdg

7200RPM on a promise Ultra ATA 66
/dev/hdg:
 Timing buffered disk reads:  64 MB in  3.02 seconds = 21.19 MB/sec
[root@smeg lpackham]# /sbin/hdparm -t /dev/hda

5400RPM on the on board
/dev/hda:
 Timing buffered disk reads:  64 MB in  4.23 seconds = 15.13 MB/sec


> On Wednesday 19 December 2001 11:32 am, Thomas Deselaers wrote:
>> Hello,
>>
>> I do have an Asus P2B-S Mainboard and since a week I have a Maxtor 60
>> GB 5400 rpm Harddrive (MAXTOR 4K060H3).
>>
>> I tried the performance of the drive and got some results which are
>> quite low I think.
>>
>> hdparm -t /dev/hdc returns
>>
>> /dev/hdc:
>>  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
>>
>> What would be a value I can expect from my hardware? And what might
>> result in higher speeds?
>>
>> thanks,
>> thomas
> 
> I dont really know, I dont think its possible to get higher then that
> from a  5400 RPM disk. Heres mine,
> 
> FUJITSU 40.9GB MPG3409AT 5400 RPM
> 
> /dev/hda:
> Timing buffered disk reads:  64 MB in  7.96 seconds =  8.04 MB/sec
> /dev/hda:
> Timing buffered disk reads:  64 MB in  7.07 seconds =  9.05 MB/sec
> /dev/hda:
> Timing buffered disk reads:  64 MB in  6.70 seconds =  9.55 MB/sec
> 
> Seems pretty normal to me. However yours is alot better then mine. -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


