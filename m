Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRCOKP2>; Thu, 15 Mar 2001 05:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131663AbRCOKPS>; Thu, 15 Mar 2001 05:15:18 -0500
Received: from shiva.jussieu.fr ([134.157.0.129]:2566 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S131660AbRCOKPM>;
	Thu, 15 Mar 2001 05:15:12 -0500
Message-ID: <3AB08FAC.657784CA@qosmos.net>
Date: Thu, 15 Mar 2001 10:47:24 +0100
From: Jerome Tollet <Jerome.Tollet@qosmos.net>
Organization: Qosmos
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.2 network performances
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i have a problem with the network layer of linux kernel 2.4.2
I wrote a minimalist program which basically sends UDP datagrams over
the network in an infinite loop.
Under Linux 2.2.x, this program floods the network and my xosview prints
that 12 MB/s are sent over my 100Mbit ethernet.

Under Linux 2.4.2, this program can't flood the network because my
xosview (the same ;-) ) tells me that 4.6MB/s are sent over my ethernet
although my cpu is not overloaded.

I think that Linux 2.4.2 limits the rate of packets sent over the
network with some soft parameters.
*Does anyone have any idea ?
*Could someone explains me the new
/proc/sys/net/core/{hot_list_length|no_cong|no_cong_thresh|mod_cong|lo_cong}
parameters ?
*Where could i see in the code this soft limits ?

Thanks for your help.
Please CC me your response while i didn't subscribed to the mailing
list.

------------------------
Jerome Tollet
jerome.tollet@qosmos.net
www.qosmos.net
------------------------
