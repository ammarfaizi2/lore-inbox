Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTLaMcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTLaMcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:32:18 -0500
Received: from pop3.telefonica.net ([213.4.129.150]:42302 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S264329AbTLaMcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:32:16 -0500
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: linux-kernel@vger.kernel.org
Subject: i18n for kernel 2.7.x?
Date: Wed, 31 Dec 2003 13:32:15 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311332.15422.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a thing: why not internationalization of kernel. That is, why not
that the kernel could display error or debug messages in different
languages (for example)?

I think that internationalization is a remarkable thing of a kernel of
any operating system. It makes the kernel project more international
(in the sense that there is no privileged language) and make that more
people feel envolved in this (because these people see the kernel less far
than before, because it "speaks" their language). And (perhaps indirectly)
it makes that more people detect more bugs: if I'm a newbee and I see
"This is a bug [...] EIP: ....", in normal circumstances (and more if I
don't know english), I don't know what can I do [If the kernel "says" the
bug in rumanian for example, then I know that is a kernel bug and, maybe,
I say it to my friend that know english...]

I believe that it could be done in the future releases of kernel (I don't
believe that it could be done in the present series (2.6) because I
believe that it implies a little bit of work!).

I'm not a kernel guru so I don't know what is necessary to do for i18n of
the kernel, but I think that it's necessary to do:

1) Make a module, M, for display all the message that now kernel displays
directly. So the core of the kernel and all the other modules send the
message to display to M and then M displays this message in the selected
language (selected in the compilation of kernel). The default language
were english as now, for example, because the kernel developers are
majorty of english speakers.

2) Translate the documentation. That is,
	a) Documentation/ directory of the kernel
	b) README file and other ./ files (as COPYRIGHT...)
		Optionally, we could say in the translated files that the "official"
		translate is the english translate (for legal purposes...)
	c) Translate the web page of the kernel (www.kernel.org) for that we
	could display the language that we selected in this page (as
	www.debian.org do).


This is all what I want to communicate to you and I _hope_ that you like
it.

Regards and happy new year,
Xan.

PS: Please don't email-me. Discusion about it in group. Thanks.

