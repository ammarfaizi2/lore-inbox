Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUKSAXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUKSAXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUKSAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:20:32 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:12952 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261214AbUKSATk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:19:40 -0500
Message-ID: <419D3F70.5090104@devicelogics.com>
Date: Thu, 18 Nov 2004 17:33:52 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.9 pktgen 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Utility is very good for traffic generation, however, you may wish to 
consider adding a parameter
to increase tx_queue_len for the device underneath if you choose to 
inject traffic from multiple
sources into the device for testing.    With the tx_queue_len set to 
defaults, I see a lot of traffic
from above getting dropped when tests are running.   I have had to 
increase this number to
60000 to get around certain test scenarios.

Just a suggestion.

Jeff

