Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUC2OYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUC2OYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:24:12 -0500
Received: from opersys.com ([64.40.108.71]:11022 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262902AbUC2OYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:24:09 -0500
Message-ID: <406832E7.6040100@opersys.com>
Date: Mon, 29 Mar 2004 09:29:59 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Pavel Mironchik <p.mironchik@sam-solutions.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel / Userspace Data Transfer
References: <1080528430.40678e2e9eb3a@www.beonline.com.au>	<406799F3.1020508@opersys.com> <20040329124542.019edd8b.p.mironchik@sam-solutions.net>
In-Reply-To: <20040329124542.019edd8b.p.mironchik@sam-solutions.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Mironchik wrote:
> The best Userspace-kernelspace-Userspace transfer thing is soket.
> Unix or TCP/UDP sockets API is avaible from kernel space.
> You should use it...

Sockets suck for the kind of application relayfs is used for. Try
running LTT on sockets, for example, and let me know what type of
performance you get. For simple transfers, maybe, but for real
high-speed, large scale data transfers, sockets just don't cut it.
That's where relayfs is most useful.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

