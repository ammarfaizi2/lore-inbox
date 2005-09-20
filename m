Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVITPUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVITPUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVITPUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:20:50 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:14091 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965034AbVITPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:20:50 -0400
Message-ID: <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <56402.10.10.10.28.1127229646.squirrel@linux1>
In-Reply-To: <200509201025.36998.gene.heskett@verizon.net>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
    <200509201005.49294.gene.heskett@verizon.net>
    <20050920141008.GA493@flint.arm.linux.org.uk>
    <200509201025.36998.gene.heskett@verizon.net>
Date: Tue, 20 Sep 2005 11:20:46 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Gene Heskett" <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050920112046_74708"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Sep 2005 15:20:20.0154 (UTC) FILETIME=[D023D1A0:01C5BDF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050920112046_74708
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, September 20, 2005 10:25 am, Gene Heskett said:

> Humm, what are they holding out for, more ram or more cpu?:-)
>
> FWIW, http://master.kernel.org doesn't show it either just now.

Gene,

While kernel.org snapshots will no doubt be working again shortly, you
might want to consider using git.  It reduces the amount you have to
download for each release a lot.

It's really easy to grab a copy of git and use it to grab the kernel:

mkdir kernel
cd kernel
wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
tar -xvjf git-core-0.99.7.tar.bz2
cd git-core-0.99.7
make install
cd ..

git clone \
rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
linux

cd linux
git checkout


The above is given as an attachment as well because of annoying word wrap
issues with the long url's.   Anyway, after that you can stay current with
the latest Linus release with a simple  "git pull".

Cheers,
Sean


------=_20050920112046_74708
Content-Type: application/octet-stream; name="grab.kernel"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="grab.kernel"

bWtkaXIga2VybmVsIApjZCBrZXJuZWwKd2dldCBodHRwOi8va2VybmVsLm9yZy9wdWIvc29mdHdh
cmUvc2NtL2dpdC9naXQtY29yZS0wLjk5LjcudGFyLmJ6Mgp0YXIgLXh2amYgZ2l0LWNvcmUtMC45
OS43LnRhci5iejIgCmNkIGdpdC1jb3JlLTAuOTkuNyAKbWFrZSBpbnN0YWxsCmNkIC4uCmdpdCBj
bG9uZSByc3luYzovL3d3dy5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC0yLjYuZ2l0IGxpbnV4CmNkIGxpbnV4CmdpdCBjaGVja291dAo=
------=_20050920112046_74708--

