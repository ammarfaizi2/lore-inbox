Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269969AbUJEP5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269969AbUJEP5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269968AbUJEP52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:57:28 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21151 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269696AbUJEP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:57:15 -0400
Message-ID: <4162C44A.8060804@nortelnetworks.com>
Date: Tue, 05 Oct 2004 09:56:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: High Resolution Timer patches crash with slower DDR memory?
References: <NFBBICMEBHKIKEFBPLMCEEJGIMAA.aathan-linux-kernel-1542@cloakmail.com>
In-Reply-To: <NFBBICMEBHKIKEFBPLMCEEJGIMAA.aathan-linux-kernel-1542@cloakmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew A. wrote:
> Does it make sense to anyone that when I run a 2.6.8.1 system patched with HRT using 2 sticks of PC3200 DDR memory (512Meg total) it
> works fine, but when I add a stick of PC2700 DDR memory (3 sticks total to 1024Meg) it throws kernel panics and page fault errors?
> Same system running an unpatched kernel has no problems.

Could be bad memory that gets used in one case and not the other.  Try running a 
memory scanner to see if you have a bad stick.

Chris
