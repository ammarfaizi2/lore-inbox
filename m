Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWBCODp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWBCODp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWBCODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:03:45 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:41097 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750824AbWBCODo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:03:44 -0500
Message-ID: <43E36319.7020803@sw.ru>
Date: Fri, 03 Feb 2006 17:05:13 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com>
In-Reply-To: <43E35105.3080208@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've also seen that openvz introduces a 'vps_info_t' object, which looks
> like a some virtualization backend. I'm not sure to have well understood
> this framework. What the idea behind it ? is it to handle different
> implementation of the virtualization ?
Yes, it was a small container backend, where small piece of 
per-container info required for VPIDs is stored.
This patch will be resent in a bit another form, non-related to VPIDs 
itself. Something like an abstract container declaration.

Kirill

