Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUFVPrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUFVPrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUFVPoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:44:11 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56000 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264648AbUFVPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:31:23 -0400
Message-ID: <40D850C5.1080802@nortelnetworks.com>
Date: Tue, 22 Jun 2004 11:31:17 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG?:   G5 not using all available memory -- SOLVED
References: <1087858881.22687.36.camel@gaston>
In-Reply-To: <1087858881.22687.36.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I went and opened the case.

Lo and behold the bottom bank had three DIMMs while the top bank had only one. 
Not sure if it came like that or if someone messed with it. I moved one of the 
DIMMs to even it out, and sure enough its showing up with the full amount now.

Sorry to bother you all...

Chris
