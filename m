Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVAKBOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVAKBOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVAKBJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:09:30 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:54986 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262644AbVAKBDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:03:50 -0500
Message-ID: <41E325F5.60901@drzeus.cx>
Date: Tue, 11 Jan 2005 02:03:49 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
References: <MDEHLPKNGKAHNMBLJOLKGEOFAPAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEOFAPAB.davids@webmaster.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
> 	From reading this thread, it's not clear to me which of two possible
> situations we are in:
> 
> 	1) The mail server is rejecting perfectly valid email based upon it
> requiring SPF or some similar problem with that mail server.
> 
> 	2) The mail server is rejecting email because SPF is misconfigured on the
> other end.
> 


Since it's a bit off-topic for LKML it's being discussed off-list. The 
problem was with the DNS servers. Since the mail server could not 
determine SPF status for the domain it returned a temporary error 
(hoping that the DNS problem would get resolved).

So the situation is more towards 1). The mail is valid, but there is a 
DNS (or firewall) misconfigured somewhere.

Rgds
Pierre
