Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423340AbWF1OH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423340AbWF1OH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423339AbWF1OH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:07:57 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11702 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423337AbWF1OH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:07:56 -0400
Message-ID: <44A28964.2090006@fr.ibm.com>
Date: Wed, 28 Jun 2006 15:51:32 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Lezcano <dlezcano@fr.ibm.com>
CC: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com>
In-Reply-To: <449FF5AE.2040201@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano wrote:
> Andrey Savochkin wrote:
> 
>> Structures related to IPv4 rounting (FIB and routing cache)
>> are made per-namespace.

Hi Andrey,

if the ressources are private to the namespace, how do you will handle 
NFS mounted before creating the network namespace ? Do you take care of 
that or simply assume you can't access NFS anymore ?

Regards

  -Daniel
