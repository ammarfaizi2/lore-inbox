Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTICO7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTICO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:59:11 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:8908 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263457AbTICO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:59:08 -0400
Subject: RE: Driver Model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: root@chaos.analogic.com, "'James Clark'" <jimwclark@ntlworld.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002301c37228$bbc89950$294b82ce@stuartm>
References: <002301c37228$bbc89950$294b82ce@stuartm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062601073.19058.70.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 15:57:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 15:36, Stuart MacDonald wrote:
> If the MODULE_LICENSE() macro is what determines taint, what's to
> prevent a company from compiling their driver in their own kernel tree
> with that macro and releasing it binary-only? Wouldn't that module
> then be taint-free?

They would be representing their module is GPL when its not, obtaining
services by deceving people (3rd party support) and if they used _GPL
symbols probably violating the DMCA by bypassing a digital rights
system.

In practice we've had two cases we know about where someone tried this,
one at least was almost certainly an accident the other one the vendor
seems to now have fixed after the threat of acute bad publicity.

You could equally ask the same question about any other measure - its
no different to "I could shoot the shopkeeper and not pay", its an
incentive to behave, a way for developers to make it clear their code
isnt for stealing and without denying people the choice of what they
run. The reputable vendors on the whole not only seem to obey it but
actually put informative MODULE_LICENSE() tags into their code for
their proprietary licenses.


Alan

