Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUESM2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUESM2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUESM2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:28:43 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:16553 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S263028AbUESM2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:28:41 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-7.tower-45.messagelabs.com!1084969718!3045435
X-StarScan-Version: 5.2.11; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Wed, 19 May 2004 08:28:16 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7605FAEB88@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Thread-Index: AcQ9VPiXX/j8TXmzR5KxjqJlarj9GQAR7xvA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Justin Piszcz" <jpiszcz@hotmail.com>, <baldrick@free.fr>,
       <gene.heskett@verizon.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may not dause -data corruption- but it deleted a whole bunch of files
that were in use before the previous reboot.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bartlomiej
Zolnierkiewicz
Sent: Tuesday, May 18, 2004 9:23 AM
To: Justin Piszcz; baldrick@free.fr; gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.

On Monday 17 of May 2004 17:06, Justin Piszcz wrote:
> Sorry to all, it turns out (in two separate cases I had two different
> problems that affected the results).
>
> Case 1: No SMP turned on for CPU w/HT after fix (~4.78 seconds compile
time
> (2.6GHZ w/HT))
> Case 2: Box had 4GB of NON-ECC memory in it, only recognized 2.56GB,
took
> out (2) 1GB DDR DIMM's, and the speed returned what it should be.
(~4.3
> seconds compile time (3.0GHZ w/HT))
>
> The control box was a 2.53GHZ (533MHZ BUS w/NO HT) = ~5.3seconds
>
> I have not tested 2.6.6 recently, but in one of my tests I believe it
> worked OK, ever since 2.6.6 removed my /etc/lilo.conf and /etc/mtab
and
> several other files, I do not wish to touch that kernel with a 10 foot
poll
> :-P due to the IDE disk flush/cache issue.

I told you this already: 2.6.6 IDE changes don't cause data corruption
- but fixes some instead (that's why there were merged so quickly!)
so stop spreading FUD and see
http://bugme.osdl.org/show_bug.cgi?id=2672.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


