Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTF0Kiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTF0Kiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:38:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42884
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264242AbTF0Kis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:38:48 -0400
Subject: Re: [PATCH] fix inlining with gcc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030626230824.GM3827@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
	 <20030626230824.GM3827@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056711001.4348.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 11:50:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 00:08, J.A. Magallon wrote:
> This fixes inlining (really, not-inlining) with gcc3. How about next -pre ?

Benchmark that before you blindly assume its right. Gcc not inlining large
stuff actually appears to be _smarter_ than the authors of the code

