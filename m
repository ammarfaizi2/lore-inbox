Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJAQOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJAQOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:14:30 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:8766 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262240AbTJAQO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:14:28 -0400
From: Jos Hulzink <josh@stack.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>, ocsy@yandex.ru
Subject: Re: How to use module in 2.6
Date: Wed, 1 Oct 2003 18:14:25 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <1065006634.1144.39.camel@ocsy> <1065009240.1144.46.camel@ocsy> <20031001083021.125e817d.rddunlap@osdl.org>
In-Reply-To: <20031001083021.125e817d.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310011814.25330.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Oct 2003 17:30, Randy.Dunlap wrote:
> On 01 Oct 2003 15:54:00 +0400 ocsy <ocsy@yandex.ru> wrote:
> | Yes i make it))Kernel comile and modules was done (make modules after
> | that make modules_install)And than reboot....
> | But after that I type insmod <module_name> and I see on a screen a
> | LITTLE warning (fatal error) that talk to me module can be load to the
> | kernel becouse it have old format))
>
> insmod module.ko, not insmod module.o
>
> Or (preferable) use modprobe module
>
> | I think than I must look for modutils (witch can support kernell 2.6 new
> | modules format) but I can't find it...
>
> modutils are for before 2.6.
> 2.6 uses module-init-tools only.

Not really an improvement IMHO. The returned errors are unclear, the tools 
seem to ignore the verbose command line option. As a result I have been 
fighting with ALSA modules, modprobe.conf and modules.conf for days now. I've 
not managed to get all dependancies right yet, the only way to get my SB Live 
working is loading 20 modules by hand, one at a time... Somehow modprobe 
remains complaining about unresolved symbols.

FWIW: 2.6.0 test 6, module-init-tools 0.9.14, mandrake 9.1 with modutils 
deinstalled.

Jos
