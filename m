Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVCEMVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVCEMVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVCEMVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:21:49 -0500
Received: from [62.206.217.67] ([62.206.217.67]:42951 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262559AbVCEMVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:21:48 -0500
Message-ID: <4229A45C.8020506@trash.net>
Date: Sat, 05 Mar 2005 13:21:48 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: govind raj <agovinda04@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Insmod  error ip_nat_ftp
References: <BAY10-F149DDACF5CCB13E7B1DED1D65D0@phx.gbl>
In-Reply-To: <BAY10-F149DDACF5CCB13E7B1DED1D65D0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

govind raj wrote:
> /lib/modules/2.4.29/kernel/net/ipv4/netfilter/ip_nat_ftp.o: init_module: 
> Device or resource busy

You probably already have in already statically linked in. Check your
.config.

Regards
Patrick
