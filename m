Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266317AbUGJSJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUGJSJF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUGJSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:09:05 -0400
Received: from imap.gmx.net ([213.165.64.20]:33679 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266317AbUGJSJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:09:02 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Jean Francois Martinez <jfm512@free.fr>
Subject: Re: Integrated ethernet on SiS chipset doesn't work
Date: Sat, 10 Jul 2004 20:09:30 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <1089480939.2779.22.camel@agnes>
In-Reply-To: <1089480939.2779.22.camel@agnes>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102009.33577.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 19:35, Jean Francois Martinez wrote:
> I have a friend who owns a computer manufactured by Medion and who
> sports an MSI motherboard who has a SiS chipset.  The MSI motherboard 
> seems to have ben made specially for Medion since it isn't 
> referenced on MSI's site.  The problems is that the integrated ethernet
> doesn't work at all under Linux be it with 2.4 or 2.6 kernel.  He can't 
> ping or connect to other boxes.  His ethernet works when he boots
> Windows.
> 
> I include the output of lspci

I have an Medion computer either and nearly the same components. Did you
enabled SiS900 support in kernel? Can you attach the dmesg output?
The only curios thing with the onboard sis900 chip is, that it does not work
in 100Mb full-duplex mode with the stable kernel tree, but there is a patch
included in -mm patchset, which makes sis900 working in 100Mb full-duplex
mode too.

greets dominik
