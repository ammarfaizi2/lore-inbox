Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVAQINQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVAQINQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVAQINQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:13:16 -0500
Received: from news.suse.de ([195.135.220.2]:12996 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261294AbVAQINC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:02 -0500
Message-ID: <41EB600A.8050006@suse.de>
Date: Mon, 17 Jan 2005 07:49:46 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jyri.poldre@artecdesign.ee
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver link state propagation to ip stack
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
In-Reply-To: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jüri Põldre wrote:

> My question is:  Does the kernel handle  the interface state/routing tables
> modifications due to link changing automatically or is there some external
> daemon required to do that. Any links are greatly appreciated.

You might want to have a look at ifplugd (from memory:
http://0pointer.de/~lennart/). It works very well for me (i ifup/ifdown
my interfaces with it, works fine at least as long as there is only one
cable plugged at a time :-)

Stefan

