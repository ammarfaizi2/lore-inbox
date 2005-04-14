Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVDNXBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVDNXBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDNXBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:01:00 -0400
Received: from grunt6.ihug.co.nz ([203.109.254.46]:7065 "EHLO
	grunt6.ihug.co.nz") by vger.kernel.org with ESMTP id S261631AbVDNXAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:00:50 -0400
Date: Fri, 15 Apr 2005 11:00:41 +1200 (NZST)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost.localdomain
Reply-To: steve@perfectpc.co.nz
To: Omkhar Arasaratnam <iamroot@ca.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 ip_conntrack: table full, dropping packet.
In-Reply-To: <425EF518.5030108@ca.ibm.com>
Message-ID: <Pine.LNX.4.62.0504151057560.1275@localhost.localdomain>
References: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
 <425EF518.5030108@ca.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you sure the ip_conntrack itself isn't ACTUALLY full? Have you tried
> increase this increasing this via
> /proc/sys/net/ipv4/netfilter/ip_conntrack_max?

Just did it, thanks for reply. The 2.4 kernel I ran in the same box does 
not have such problem, maybe there is a change in the algorithm of 
calculating ip_contract_max in the recent kernel? What number you suggest 
(my firewall box has only 64Mb of RAM)

Thanks,

Kind regards,
