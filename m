Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTF0NHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTF0NHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 09:07:32 -0400
Received: from robur.slu.se ([130.238.98.12]:4874 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id S264262AbTF0NHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 09:07:31 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16124.17582.796111.577015@robur.slu.se>
Date: Fri, 27 Jun 2003 15:20:46 +0200
To: "adamski" <adam_lista_linux@poczta.onet.pl>
Cc: "Robert Olsson" <Robert.Olsson@data.slu.se>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: RE: How to do kernel packet forwarding performance analysys - please comment on my method 
In-Reply-To: <GMEGLMHAELFDACHHIEPICEBPCFAA.adam_lista_linux@poczta.onet.pl>
References: <16124.11592.136156.61126@robur.slu.se>
	<GMEGLMHAELFDACHHIEPICEBPCFAA.adam_lista_linux@poczta.onet.pl>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adamski writes:

 > i would like to start two flows through linux router: PHB EF and BE PHB..
 > like voip and ftp or so...
 > 
 > than i want to analyse what exactly happens ... since my theoretical
 > analysys show delays (or latencies - from packet entering the NIC to going
 > out of the outgoing interface) of hundereds of usec (~200us) while
 > experiments shows 5-10ms !!!!! with CBQ (configured like CBWFQ and LLQ)

 Seems you have to add your own hooks for this and I guess you've seen 
 CONFIG_NET_PROFILE which does accurate measurements for network related  
 operations. It was long time since I used though...

 Cheers.
						--ro
