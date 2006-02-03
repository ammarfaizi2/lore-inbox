Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWBCPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWBCPlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWBCPlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:41:07 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17035 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750854AbWBCPlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:41:06 -0500
Message-ID: <43E37983.9080202@fr.ibm.com>
Date: Fri, 03 Feb 2006 16:40:51 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <43E36319.7020803@sw.ru>
In-Reply-To: <43E36319.7020803@sw.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>> I've also seen that openvz introduces a 'vps_info_t' object, which looks
>> like a some virtualization backend. I'm not sure to have well understood
>> this framework. What the idea behind it ? is it to handle different
>> implementation of the virtualization ?
> 
> Yes, it was a small container backend, where small piece of
> per-container info required for VPIDs is stored.
> This patch will be resent in a bit another form, non-related to VPIDs
> itself. Something like an abstract container declaration.

That is an interesting concept because it could probably be used to satisfy
all parties. It seems that everyone has his own idea on what a container
should "feel" like, in term of pid virtualisation and container parent hood
also, at least. May be there is not a unique model.

Just booted 2.6.15-openvz.025stab014, I'm going to have a look at the
concepts you put place.

C.
