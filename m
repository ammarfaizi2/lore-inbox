Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753559AbWKGPKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbWKGPKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbWKGPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:10:32 -0500
Received: from 8.ctyme.com ([69.50.231.8]:43963 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1752906AbWKGPKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:10:32 -0500
Message-ID: <4550A1E6.1070708@perkel.com>
Date: Tue, 07 Nov 2006 07:10:30 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Paul Rolland <rol@as2917.net>, "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: could not find filesystem /dev/root - menucinfig
References: <02e401c7023a$fdcce1d0$4b00a8c0@donald> <Pine.LNX.4.61.0611071013420.11192@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611071013420.11192@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured out the problem. the SATA drivers weren't being compiled. 
That's because the menu system was rearanged. May I suggest that if you 
are going to change the structure that you include some upgrade mapping 
so that if old items are mapped to new items and people like me won't 
waste many hours just to find out that what I though was selected isn't.

menuconfig needs to be upgrade smart.

