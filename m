Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHVRo4>; Thu, 22 Aug 2002 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHVRo4>; Thu, 22 Aug 2002 13:44:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51699 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314680AbSHVRoy>; Thu, 22 Aug 2002 13:44:54 -0400
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, rohan@myeastern.com, jh@ionium.org
In-Reply-To: <3D64AB95.DC8FD965@hrzpub.tu-darmstadt.de>
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de>
	<3D62482D.4030500@myeastern.com> 
	<3D6355C5.6A51E11E@hrzpub.tu-darmstadt.de>
	<1029936975.26425.21.camel@irongate.swansea.linux.org.uk> 
	<3D64AB95.DC8FD965@hrzpub.tu-darmstadt.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:48:41 +0100
Message-Id: <1030038521.3161.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 10:15, Jens Wiesecke wrote:
> So again my question: Can I do anything to help to debug this problem ?

The version it broke at it is itself a lot of help. Build a kernel with
no apm, no acpi, no agp, no compiled in audio, non smp, non numa, no
apic support.

Let me know if that boots

