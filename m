Return-Path: <linux-kernel-owner+w=401wt.eu-S1753888AbWLRLxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbWLRLxo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbWLRLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:53:43 -0500
Received: from userg503.nifty.com ([202.248.238.83]:63531 "EHLO
	userg503.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbWLRLxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:53:43 -0500
DomainKey-Signature: a=rsa-sha1; s=userg503; d=nifty.com; c=simple; q=dns;
	b=1sv+zsIGmi+g4G6HUvsmvpRSBW1fhAHlJEqb63YLZGdNJ5r0ZGV0Yyxybbg1qBwm+
	JNDPkEMkqHfZAEMk67GIA==
Date: Tue, 19 Dec 2006 05:55:11 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during
 file-transfer
Message-Id: <20061219055511.15924b4a.komurojun-mbn@nifty.com>
In-Reply-To: <20061218030113.GT10316@stusta.de>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
	<20061217040222.GD17561@ftp.linux.org.uk>
	<20061217232311.f181302f.komurojun-mbn@nifty.com>
	<20061218030113.GT10316@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> What network cards are in the client and the server?

DL10022-based pcmcia network card(both client and server)
The driver name is pcnet_cs.
 
> Are there any error messages your client gives or in the log files?

no error messages.

I capture the packet of ftp transfer by ethereal.
I found the malformed packet when it stops.

I will investigate it further.

Thanks!

Best Regards
Komuro

