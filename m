Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWEPVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWEPVUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWEPVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:20:05 -0400
Received: from mail.siegenia-aubi.com ([217.5.180.129]:12942 "EHLO
	alg-1.siegenia-aubi.com") by vger.kernel.org with ESMTP
	id S932065AbWEPVUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:20:04 -0400
Message-ID: <FC7F4950D2B3B845901C3CE3A1CA6766015CC246@mxnd200-9.si-aubi.siegenia-aubi.com>
From: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 23:19:55 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During communication in between application and megaraid 
> driver via IOCTL, the system displays messages which are not 
> easy to track down.
> Following is one of the messages and same messages with 
> different values are poping up regularly.
> ---
> Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
> ---

We have this message too on our main database server; the interesting part
is, that the application, which triggers this error, is a database (MaxDB)
and the process name is "kernel"... Just to avoid confusion: look if there's
an application with such name running on your system.


Greetz,


SIEGENIA-AUBI KG
Informationswesen
 
i.A.
 
Markus Döhr
SAP-CC/BC, SAPDB-DBA

Tel.:	 +49 6503 917-152
Fax:	 +49 6503 917-7152
E-Mail: markus.doehr@siegenia-aubi.com
Internet: http://www.siegenia-aubi.com 
  
