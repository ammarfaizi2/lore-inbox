Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVCNNMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVCNNMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCNNMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:12:31 -0500
Received: from moritz.faps.uni-erlangen.de ([131.188.113.15]:58085 "EHLO
	moritz.faps.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261220AbVCNNMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:12:30 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: Resending ethernet packets to direct neighbours
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Mon, 14 Mar 2005 14:12:29 +0100
Message-ID: <09766A6E64A068419B362367800D50C0B58A6A@moritz.faps.uni-erlangen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Resending ethernet packets to direct neighbours
thread-index: AcUol3mbOqiWeXA0SnS5cEpIk98PZg==
From: "Weber Matthias" <weber@faps.uni-erlangen.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have a pc with five ethernet devices onto and want to resend ethernet packets coming in from one device to four direct neighbours (distance 1). Therefore i have installed a packet handler receiving skbs.
Now i have the following questions:
1) is it enough to change the skb->dev to the output device, rebuild the ethernet header and call dev_queue_xmit()?
2) how to i get the destination ethernet address of the physically direct neighbour within the packet handler? I believe, that i have to use the neighour caches but have not idea how...

Any help would be appreciated!


Bye
Matthias

