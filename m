Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVBRRAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVBRRAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVBRRAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:00:34 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:9914 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S261404AbVBRRA2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:00:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel modules query
Date: Fri, 18 Feb 2005 09:00:25 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301BA9E4C@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel modules query
Thread-Index: AcUVnbUiK/IxWvaxTUiXvVupCWbt3gAPWn/Q
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "linux lover" <linux.lover2004@gmail.com>, <kernelnewbies@nl.linux.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Feb 2005 17:00:27.0735 (UTC) FILETIME=[58896E70:01C515DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of linux lover
>Sent: Friday, February 18, 2005 1:36 AM
>To: kernelnewbies@nl.linux.org; linux-kernel@vger.kernel.org
>Subject: Kernel modules query
>
>Hello,
>        I want to know can a variable be exported by a linux kernel
>modules? How can i make a variable getting assigned in kernel module
>available to other kernel modules?
>regards,
>linux.lover.

EXPORT_SYMBOL(var_name);

For example see arch/i386/kernel/time.c & jiffies_64 (2.6.10 source).

Aleks.

