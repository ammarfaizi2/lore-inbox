Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbTC0RXJ>; Thu, 27 Mar 2003 12:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RWF>; Thu, 27 Mar 2003 12:22:05 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:64485 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S263319AbTC0RVp>; Thu, 27 Mar 2003 12:21:45 -0500
Message-Id: <5.1.0.14.2.20030327092916.071f02c8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Mar 2003 09:32:22 -0800
To: Johannes Erdfelt <johannes@erdfelt.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [BK] Bluetooth updates for 2.4.21-pre6
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20030326205309.A9855@sventech.com>
References: <5.1.0.14.2.20030326174507.05351f98@unixmail.qualcomm.com>
 <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
 <5.1.0.14.2.20030326174507.05351f98@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:53 PM 3/26/2003, Johannes Erdfelt wrote:
>On Wed, Mar 26, 2003, Max Krasnyansky <maxk@qualcomm.com> wrote:
>> <maxk@qualcomm.com> (03/03/19 1.1106)
>>    [Bluetooth]
>>    Do not submit more than one usb bulk rx request. It crashes uhci.o driver.
>
>I don't recall seeing an email about this.
>uhci.o should handle this situation correctly.
Sorry. My bad. I meant usb-uhci.

usb-uhci does crash in unlink_qh() when one of the multiple bulk rx urbs 
is unlinked. I didn't have time to investigate and therefor did not submit
bug report.

Max

