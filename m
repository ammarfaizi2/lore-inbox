Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272865AbTG3MmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272876AbTG3MmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:42:12 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:52143 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S272865AbTG3MmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:42:09 -0400
Date: Wed, 30 Jul 2003 18:46:53 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: =?iso-8859-1?Q?Frank_Sch=E4fer?= <Frank.Schafer@setuza.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Simple module question
In-Reply-To: <1059472604.1109.6.camel@ADMIN.setuza.cz>
Message-ID: <Pine.LNX.4.44.0307301845430.12027-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add this to modules.conf 
# man modules.conf

tomar

On Tue, 29 Jul 2003, Frank Schäfer wrote:

> Hi list,
> 
> We have a monolithic kernel 2.4.18 using ip-tables. The ftp contrack
> module takes a optional parameter port=xxxxx.
> 
> This parameter should be puttable by the kernel parameters. So I put it
> on the addons line in lilo.conf.
> 
> The parameter doesn't show up in the boot dmesg, I can see it in
> /proc/cmdline, but it doesn't seem to work. No ftp connection can be
> made on this port.
> 
> Could anzbody put me a hint?
> 
> Thanks in advance
> Frank
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

