Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264168AbRFFVei>; Wed, 6 Jun 2001 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264169AbRFFVe2>; Wed, 6 Jun 2001 17:34:28 -0400
Received: from f164.law8.hotmail.com ([216.33.241.164]:23314 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264168AbRFFVeN>;
	Wed, 6 Jun 2001 17:34:13 -0400
X-Originating-IP: [152.14.51.153]
From: "ashley thomas" <ashlythomas@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: pcap_setfilter: to dump the unread packets
Date: Wed, 06 Jun 2001 21:34:06 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1647rzCQI4hrGXKqZG00016228@hotmail.com>
X-OriginalArrivalTime: 06 Jun 2001 21:34:07.0134 (UTC) FILETIME=[6A5B23E0:01C0EED0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using libpcap 0.6 on Linux to capture packets from the interface.

In my application I am using pcap_setfilter to modify the filter
for capturing packets from the interface.
But after filter has been modified the libpcap retains the packets
that libpcap had got using the old filter (ie before pcap_setfilter
is called)

This filtering is done using a socket. So in pcap_setfilter is there
any way we can "dump" all the 'unread' packets captured using the old
filter which are present in the socket's buffer ?

thanks a lot
Ashley







_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

