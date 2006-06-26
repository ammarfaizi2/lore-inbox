Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWFZPEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFZPEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWFZPEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:04:33 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:37541 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932355AbWFZPEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:04:31 -0400
Message-ID: <449FF77D.3080707@fr.ibm.com>
Date: Mon, 26 Jun 2006 17:04:29 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: Re: [patch 4/4] Network namespaces: playing and debugging
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <20060626135537.D28942@castle.nmd.msu.ru>
In-Reply-To: <20060626135537.D28942@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> Temporary code to play with network namespaces in the simplest way.
> Do
> 	exec 7< /proc/net/net_ns
> in your bash shell and you'll get a brand new network namespace.
> There you can, for example, do
> 	ip link set lo up
> 	ip addr list
> 	ip addr add 1.2.3.4 dev lo
> 	ping -n 1.2.3.4
> 

Is it possible to setup a network device to communicate with the outside ?
