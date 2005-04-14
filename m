Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVDNW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDNW4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDNW4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:56:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:64991 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261625AbVDNW4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:56:30 -0400
Message-ID: <425EF518.5030108@ca.ibm.com>
Date: Thu, 14 Apr 2005 18:56:24 -0400
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: steve@perfectpc.co.nz
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 ip_conntrack: table full, dropping packet.
References: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steve@perfectpc.co.nz wrote:

>
> Hi,
>
> I thought this problem has been fixed but apparently not in 2.6.11.7.
> Is there any patch for it ? Thanks
>
>
Are you sure the ip_conntrack itself isn't ACTUALLY full? Have you tried
increase this increasing this via
/proc/sys/net/ipv4/netfilter/ip_conntrack_max?

O




