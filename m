Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUIUNyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUIUNyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIUNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:54:46 -0400
Received: from cecom6.monmouth.army.mil ([134.80.0.9]:65172 "EHLO
	cecom6.monmouth.army.mil") by vger.kernel.org with ESMTP
	id S267223AbUIUNyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:54:38 -0400
Message-ID: <E3E30069B061524E90BCEE4417E30661138533@monm207.monmouth.army.mil>
From: "Huber, George K RDECOM CERDEC STCD SRI" <George.K.Huber@us.army.mil>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linux-c-programming@vger.kernel.org, linux-admin@vger.kernel.org,
       linux-newbie@vger.kernel.org
Subject: RE: Network Statistics Collection
Date: Tue, 21 Sep 2004 09:54:23 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejas wondered:

>I am working on a company project and as a part of it - I have to
>collect and show some network information on the Monitoring utility.
>Please help to find out that how can I collect these information from
>a Linux Machine.

>1. Number of active TCP connection
>2. Information of Active connections (Source and Dest IP, Source and Dest
Port)
>3. Retransmitted packets due to Duplicate ACK and SACK
>4. Connection Duration and RTT
>5. Transmission Troughput (in KB/Sec)
>6. Number of Newly Created TCP Connections
>7. Closed TCP Connections
>8. Total Data transmitted (in byte)
>9. Total Data Retransmitted (in byte)

Take a look at iptraf - it does most (if not all of what you want).  Through
a
study of its source code you should be able to figure out how to do what you
want.

George
