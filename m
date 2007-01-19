Return-Path: <linux-kernel-owner+w=401wt.eu-S932861AbXASDBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbXASDBx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXASDBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:01:52 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47641 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932868AbXASDBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:01:51 -0500
Message-ID: <45B03497.6020502@garzik.org>
Date: Thu, 18 Jan 2007 22:01:43 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] make hdlc_setup() static again
References: <20070111134859.GD20027@stusta.de>
In-Reply-To: <20070111134859.GD20027@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> hdlc_setup was exported, but this export was never used.
> 
> If a driver using it actually shows up it can still be exported again.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: Krzysztof Halasa <khc@pm.waw.pl>

applied


