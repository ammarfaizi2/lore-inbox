Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUA3B4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUA3BxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:53:18 -0500
Received: from rxrelay.lga.net.sg ([203.92.84.247]:47283 "HELO
	rxrelay.lga.net.sg") by vger.kernel.org with SMTP id S266530AbUA3Bwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:52:38 -0500
Message-ID: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
From: Vanitha Ramaswami <vanitha@agilis.st.com.sg>
Reply-To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
To: "'redhat-ppp-list@redhat.com'" <redhat-ppp-list@redhat.com>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Help in writing a synchrnous ppp driver
Date: Fri, 30 Jan 2004 09:51:41 +0800
Organization: Agilis
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In linux kernel, what is the difference between the ppp_synctty.c
(PPP synchronous TTY device driver) and syncppp.c (synchronous ppp)
functions..?

I have a High speed serial driver that is capable of doing HDLC framing
using a Network Processor. I want to run PPP on that serial driver. 
The device driver has just provided functions to read/write on the device.

I intend to add a proprietary header to the packets coming out of PPP.
Do i need to use the PPP synchronous TTY device driver or the one similar
to syncppp.c. I am not clear of when to use the syncppp functions sppp_input etc.?

To use the functions in ppp_synctty.c,  then does the driver also needs to be a TTY
driver.?

Whether all the linux driver written for serial devices need to be TTY drivers..?

Thanks,
Vanitha

