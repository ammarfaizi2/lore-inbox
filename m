Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJAPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJAPi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:38:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:33256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbTJAPix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:38:53 -0400
Date: Wed, 1 Oct 2003 08:30:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ocsy@yandex.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use module in 2.6
Message-Id: <20031001083021.125e817d.rddunlap@osdl.org>
In-Reply-To: <1065009240.1144.46.camel@ocsy>
References: <1065006634.1144.39.camel@ocsy>
	<slrnbnlem5.566.usenet.2117@home.andreas-s.net>
	<1065009240.1144.46.camel@ocsy>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2003 15:54:00 +0400 ocsy <ocsy@yandex.ru> wrote:

| Yes i make it))Kernel comile and modules was done (make modules after
| that make modules_install)And than reboot....
| But after that I type insmod <module_name> and I see on a screen a
| LITTLE warning (fatal error) that talk to me module can be load to the
| kernel becouse it have old format))

insmod module.ko, not insmod module.o

Or (preferable) use modprobe module

| I think than I must look for modutils (witch can support kernell 2.6 new
| modules format) but I can't find it...

modutils are for before 2.6.
2.6 uses module-init-tools only.

--
~Randy
