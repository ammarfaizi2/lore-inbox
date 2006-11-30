Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967935AbWK3VvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967935AbWK3VvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967936AbWK3VvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:51:12 -0500
Received: from mail2.keyvoice.com ([12.153.69.53]:114 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S967935AbWK3VvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:51:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reserving a fixed physical address page of RAM.
Date: Thu, 30 Nov 2006 16:51:08 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D1082@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccUrewPRHv6hBzNS4aSIx1H7KSfTQAG4A5A
From: "Jon Ringle" <JRingle@vertical.com>
To: "Fawad Lateef" <fawadlateef@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:
> reserving_bootmem in devicemaps_init will work but I think it 
> will be better if you do this in mem_init function (here:
> http://sosdg.org/~coywolf/lxr/source/arch/arm/mm/init.c?v=2.6.
> 16;a=arm#L620),
> so that all the paging and other map related stuff completes. (CMIIW)

Ok. That seems to work ok too. Thanks.

Jon
