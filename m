Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWFZO4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWFZO4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFZO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:56:50 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:60448 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932318AbWFZO4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:56:48 -0400
Message-ID: <449FF5AE.2040201@fr.ibm.com>
Date: Mon, 26 Jun 2006 16:56:46 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru>
In-Reply-To: <20060626135427.C28942@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> Structures related to IPv4 rounting (FIB and routing cache)
> are made per-namespace.

How do you handle ICMP_REDIRECT ?



