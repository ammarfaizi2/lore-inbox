Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTHBU4g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbTHBU4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:56:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:61074 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270325AbTHBU4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:56:34 -0400
Subject: Re: .config in bzImage ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
References: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059857562.20305.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 21:52:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-02 at 19:36, Sean Estabrooks wrote:
> There was some talk of the .config file being included
> within bzImage.  Did this ever happen?  If so, how 
> does one extract the .config from the resulting image?

Randy Dunlap's ikconfig has been in 2.4-ac for a while and was just
accepted for 2.6 proper. You can embed the config for /proc,  attach
it to the binary, or just say no..

