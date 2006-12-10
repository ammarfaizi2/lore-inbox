Return-Path: <linux-kernel-owner+w=401wt.eu-S1762407AbWLJTYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762407AbWLJTYJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762416AbWLJTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:24:09 -0500
Received: from outmx019.isp.belgacom.be ([195.238.4.200]:60134 "EHLO
	outmx019.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762407AbWLJTYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:24:06 -0500
Date: Sun, 10 Dec 2006 20:23:48 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, ndrew Victor <andrew@sanpeople.com>
Subject: Re: [patch 2.6.19-git] watchdog:  at91_wdt build fix
Message-ID: <20061210192348.GA2507@infomag.infomag.iguana.be>
References: <20061208072722.85DCE1EB27F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208072722.85DCE1EB27F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> Recent miscdev changes broke various drivers, so they won't build.
> This fixes another one.

See also Andrew Victor's patch (dated 04/Dec/2006) in the
linux-2.6-watchdog tree. It's indeed the at91rm9200_wdt, the mpcore_wdt
and the omap_wdt that are affected by the miscdev changes
(See Driver core: change misc class_devices to be real devices
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=94fbcded4ea0dc14cbfb222a5c68372f150d1476 )

Greetings,
Wim.

