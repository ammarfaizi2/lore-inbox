Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272037AbTG2TuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272038AbTG2TuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:50:14 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:955 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S272037AbTG2TuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:50:09 -0400
Message-ID: <3F26CE6B.9060506@nortelnetworks.com>
Date: Tue, 29 Jul 2003 15:43:39 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, zwane@arm.linux.org.uk,
       linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vortex@scyld.com, jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
References: <1054431962.22103.744.camel@cube>	<3EDCF47A.1060605@ifrance.com>	<1054681254.22103.3750.camel@cube>	<3EDD8850.9060808@ifrance.com>	<1058921044.943.12.camel@cube>	<20030724103047.31e91a96.akpm@osdl.org>	<1059097601.1220.75.camel@cube>	<20030725201914.644b020c.akpm@osdl.org>	<Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>	<1059447325.3862.86.camel@cube>	<20030728201459.78c8c7c6.akpm@osdl.org>	<1059482410.3862.120.camel@cube> <20030729115825.5347b487.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Last time I checked (which was about 18 months ago) the maximum
> interrupts-off time on a 500MHz desktop-class machine was 80 microseconds.

You might want to bump that up a little bit.  Querying carrier signal on 
a tulip chip is 100usecs with interrupts off.

Doesn't make any difference here though.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

