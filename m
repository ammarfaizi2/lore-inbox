Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUC2QTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUC2QS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 11:18:57 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29388 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263030AbUC2QRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:17:23 -0500
Date: Mon, 29 Mar 2004 18:13:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Daniel Egger <degger@tarantel.rz.fh-muenchen.de>
Cc: Bernd Fuhrmann <silverbanana@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
Message-ID: <20040329181321.A1078@electric-eye.fr.zoreil.com>
References: <40673495.3050500@gmx.de> <20040329112402.A26390@tarantel.rz.fh-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040329112402.A26390@tarantel.rz.fh-muenchen.de>; from degger@tarantel.rz.fh-muenchen.de on Mon, Mar 29, 2004 at 11:24:02AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@tarantel.rz.fh-muenchen.de> :
[...]
> Might be a SMP related problem. Since the r8169 fix in 2.6.4 those 
> cheapass cards work fine for me albeit a bit slow using the same compiler 
> and the same kernel on UP.

Can you try (against 2.6.5-rc2):
http://www.fr.zoreil.com/people/francois/misc/20040302-2.6.5-rc2-r8169.c-test.patch

I hope it is faster/more CPU savy.

--
Ueimor
