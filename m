Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWCLAKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWCLAKY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 19:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWCLAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 19:10:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:27063 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751265AbWCLAKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 19:10:23 -0500
Message-ID: <441366EA.1090403@pobox.com>
Date: Sat, 11 Mar 2006 19:10:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: fix NULL pointer dereference detected by Coverity
References: <20060310193414.GT21864@stusta.de> <20060311034754.GA31198@htj.dyndns.org>
In-Reply-To: <20060311034754.GA31198@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Fix NULL pointer dereference detected by the Coverity checker.  Kill
> dev -> pdev -> dev conversion while at it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Adrian Bunk <bunk@stusta.de>

applied to #upstream-fixes


