Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFZP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFZP5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWFZP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:57:09 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:56750 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750729AbWFZP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:57:07 -0400
Message-ID: <44A003CD.9050204@fr.ibm.com>
Date: Mon, 26 Jun 2006 17:57:01 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <20060626194625.E989@castle.nmd.msu.ru>
In-Reply-To: <20060626194625.E989@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> On Mon, Jun 26, 2006 at 04:56:46PM +0200, Daniel Lezcano wrote:
> 
>>Andrey Savochkin wrote:
>>
>>>Structures related to IPv4 rounting (FIB and routing cache)
>>>are made per-namespace.
>>
>>How do you handle ICMP_REDIRECT ?
> 
> 
> Are you talking about routing cache entries created on incoming redirects?
> Or outgoing redirects?
> 
> 	Andrey

incoming redirects
