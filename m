Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWBCMsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWBCMsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWBCMsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:48:14 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:11353 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750750AbWBCMsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:48:13 -0500
Message-ID: <43E35105.3080208@fr.ibm.com>
Date: Fri, 03 Feb 2006 13:48:05 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru>
In-Reply-To: <20060203105202.GA21819@ms2.inr.ac.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov wrote:

>>Did you happen to catch Linus's mail about his preferred approach?  
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=113874154731279&w=2
> 
> Of course. Logically, it would be final solution.
>
> VPID approach is pragmatic: it does not modify existing logic, rather
> it relies on it. So, it just allows to use virtual pids in a simple
> and efficient way, which is enough for all known tasks.

And how bad would it be for openvz to move away from the vpid approach ? do
you have any plan for it ?

I've also seen that openvz introduces a 'vps_info_t' object, which looks
like a some virtualization backend. I'm not sure to have well understood
this framework. What the idea behind it ? is it to handle different
implementation of the virtualization ?

thanks,

C.
