Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTFPU10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTFPU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:27:26 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:44255 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264231AbTFPU1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:27:25 -0400
Date: Mon, 16 Jun 2003 23:41:00 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel 2.2.2x + 2.4 IDE backport: anybody tried >137GB disks?
Message-ID: <20030616204100.GK31162@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running kernel 2.2 + 2.4 IDE backport <http://www.ans.pl/ide/>
(originally by Andre Hedrick and later by Krzysztof Oledzki) with great
success. I'm using e2compr (also with great success) so I'm currently
limited to 2.2. The 2.4 port of e2compr <http://www.alizt.com/> was
unfortunately pretty unstable last I looked (although I'd love to be proved
wrong on this.)

I see that Krzysztof mentions some of the 48-bit IDE stuff having been
included in the backport:
http://www.google.fi/search?q=cache:69NxMdlhNMoJ:www.cs.helsinki.fi/linux/linux-kernel/2002-04/0555.html+Krzysztof+Oledzki+48-bit+ide&hl=fi&ie=UTF-8
As far as I understand, he had not had the chance to try it out on real
>137GB hardware, though.

Has anyone tried the backport with >137GB disks? If so, with what ide
chipset and disk?

The reason I'm asking is of course that I'd need to buy some larger disks,
but I'm limited to kernel 2.2 :). I have i815 and HPT370 ide on the Abit
ST6R mobo, both of which work very well with the ide patch -- but I've had
no chance to try out >137GB disks.

BTW: I also see that Marc-Christian Petersen is including a newer version
(v2.2.22.09202002) of the ide backport in his 2.2-secure patchset
<http://sourceforge.net/projects/wolk>. Is there a newer URL for the IDE
patch than <http://www.ans.pl/ide/> that I have?


-- v --

v@iki.fi
