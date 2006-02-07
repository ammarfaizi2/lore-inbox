Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWBGWTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWBGWTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWBGWTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:19:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4003 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030201AbWBGWTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:19:36 -0500
Message-ID: <43E91CF4.8020304@watson.ibm.com>
Date: Tue, 07 Feb 2006 17:19:32 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>	<20060207201908.GJ6931@sergelap.austin.ibm.com>	<43E90716.4020208@watson.ibm.com> <m1bqxide3f.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqxide3f.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
> 
> 
>>Kirill brought up that VPS can span a cluster..
>>if so how do you (Kirill) do that? You pre-partition the pids into allocation
>>ranges for each container?
>>Eitherway, if this is an important feature, then one needs to look at
>>how that is achieved in pspace (e.g. mod the pidmap_alloc() function
>>to take legal ranges into account). Should still be straight forward.
> 
> 
> Actually legal ranges already exist in the form of min/max values.
> So that is trivial to implement.
> 

Yipp, didn't want to state the obvious, but also give Kirrill a chance
to explain how its done in OpenVZ.

Ultimately, the same "partitioning" that works on vps_info, should work
on pspace.

-- Hubertus

