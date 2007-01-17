Return-Path: <linux-kernel-owner+w=401wt.eu-S1751816AbXAQABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXAQABr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXAQABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:01:47 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:48517 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbXAQABr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:01:47 -0500
Message-ID: <45AD67C4.1080502@gentoo.org>
Date: Tue, 16 Jan 2007 19:03:16 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Aurelien Jarno <aurelien@aurel32.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IPv6 router advertisement broken on 2.6.20-rc5
References: <45AD46DD.7050408@aurel32.net>
In-Reply-To: <45AD46DD.7050408@aurel32.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:
> Hi all,
> 
> I have just tried a 2.6.20-rc5 kernel (I previously used a 2.6.19 one),
> and I have noticed that the IPv6 router advertisement functionality is
> broken. The interface is not attributed an IPv6 address anymore, despite
> /proc/sys/net/ipv6/conf/all/ra_accept being set to 1 (also true for each
> individual interface configuration).

Probably fixed by
https://bugs.gentoo.org/attachment.cgi?id=107087&action=view

Daniel

