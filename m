Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270161AbTGMH7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270166AbTGMH7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:59:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31163
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270161AbTGMH7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:59:37 -0400
Subject: Re: [PATCH] Fix error path in AD1889 driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030712005716.C25528@electric-eye.fr.zoreil.com>
References: <200307111821.h6BILFpr017428@hraefn.swansea.linux.org.uk>
	 <20030712004501.B25528@electric-eye.fr.zoreil.com>
	 <20030712005716.C25528@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058083903.31919.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:11:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 23:57, Francois Romieu wrote:
> Memory leak fix: the allocated areas weren't referenced any more once the
> original error path returned.
> 
Thanks I'll push that back into 2.4

