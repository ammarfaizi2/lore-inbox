Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUAPXDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUAPXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:03:54 -0500
Received: from [198.70.193.2] ([198.70.193.2]:42715 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S265979AbUAPXDv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:03:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch] fix qla2xxx build for older gcc's
Date: Fri, 16 Jan 2004 15:04:07 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598E3A@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] fix qla2xxx build for older gcc's
Thread-Index: AcPb+BNZRlG6gY2wQAaS4yvig9NZDgAjOLbA
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2004 23:04:08.0205 (UTC) FILETIME=[0BBAABD0:01C3DC85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 15, 2004 10:15 PM, Andrew Morton wrote:
> drivers/scsi/qla2xxx/qla_def.h:1139: warning: unnamed
> struct/union that defines no instances
> drivers/scsi/qla2xxx/qla_iocb.c:440: union has no member named
> `standard' 
> 
> Older gcc's don't understand anonymous unions.
>

Thanks.  Will add to the next drop.

Regards,
Andrew Vasquez
