Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTDFPku (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTDFPku (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:40:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27790
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263016AbTDFPkt (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:40:49 -0400
Subject: Re: [PATCH] e1000 close
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030405231220.GI12864@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
	 <20030405224233.GA12746@werewolf.able.es>
	 <20030405231220.GI12864@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049640831.963.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 15:53:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 00:12, J.A. Magallon wrote:
> Supposed to cure a dev_close called without dev_open.
> Is this still needed ?

If ->close is called on a device that is not open then 
the fix is not the driver, the fix is the core code
fix.

