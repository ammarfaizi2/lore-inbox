Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVCVQTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVCVQTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVCVQTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:19:02 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:161 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261398AbVCVQSq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:18:46 -0500
Date: Tue, 22 Mar 2005 17:22:03 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>, felix-linuxkernel@fefe.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Message-ID: <20050322162203.GB19668@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, felix-linuxkernel@fefe.de,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050311202122.GA13205@fefe.de> <20050311173308.7a076e8f.akpm@osdl.org> <20050321163358.1b4968a0.akpm@osdl.org> <20050322021857.GA17972@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322021857.GA17972@linuxtv.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.45.50
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> Grab the ncp package from http://www.fefe.de/ncp/, or more specifically
> ftp://ftp.fu-berlin.de/unix/network/ncp/ncp-1.2.3.tar.bz2.
> 
> It's a very useful and handy tool for pushing around data within
> a LAN of a small workgroup, one guy does "npush foo" and yells
> at the intended recepient "do npoll". The first one to do
> it wins and gets foo ;-)

In case that description sounded too silly: The essential feature
of ncp is that it requires no configuration or installation of a
server daemon, and you don't even need to worry about host names or the
IP address of the source or destination machine. Just hook two computers
to the same network and you're ready to npush/npoll. Similar to
netcat + tar, but way more convenient.

Johannes
