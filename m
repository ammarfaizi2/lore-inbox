Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWEQMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWEQMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWEQMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:31:28 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:29089 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932540AbWEQMb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:31:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: Kernel vs drivers releases?
Date: Wed, 17 May 2006 08:31:27 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7024640@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel vs drivers releases?
Thread-Index: AcZ5ct6jeF6VeHGPSFy+BAFxNPoufAANp4GQ
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 May 2006 12:31:27.0122 (UTC) FILETIME=[D11C1720:01C679AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I woke up this morning with an idea and I tought I could ask what people
think about it...  I might be completely wrong but anyway..

I've read a lot of stuff on linux 2.6 development model which makes
either people happy or unhappy of it's really fast development speed (I
love lwn.net kernel readings... keep up the good work!).

To make the stable branch more "stable" there is even now a 2.6.x.y set
of patches which seems to be making a really nice jobs on fixing
critical (or really important) stuff (again, keep up the good work!)

One thing that I've heard most was that, using this fast development
model a lot of newer hardware gets supported quickly (also a lot of new
features...)

On the other hand many people want's to get a full stabilisation of the
actual API... Maybie even get back to a fully independant stable vs dev
tree like it used to (2.6 vs 2.7) ?  This might have been partially
addressed by the new 2.6.x.y scheme although I don't get a feeling that
everybody is totally happy with it.

This morning I tought of another approach... Maybie somebody already
suggested that earlier?

Why not completely separate the kernel part from the driver part?

We could get a bit slower development cycle on the kernel side (maybie
2-4 kernel / years) and get a really fast development cycle for the
driver set (1 / month)?

This would:
- Make people feel that the kernel API is more "stable"
- Keep the 2.6.x.y scheme running the same way to make the kernel API
even more stable
- Make new hardware supported even more rapidly

End-users could eventually simply upgrade their driver set without
updating the whole kernel ... Simplifying a lot (at least I think) the
"update" process for both the end-user and the Linux distributor.

A new 3.0 kernel could be started using this scheme with it's associated
driver set?  Then a dev 3.1 for 3 to 6 months to finally get to a stable
3.2 kernel with it's associated driver set?

Am I completely wrong?

- vin
