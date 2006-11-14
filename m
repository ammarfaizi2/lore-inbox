Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965382AbWKNMYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbWKNMYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWKNMYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:24:40 -0500
Received: from iona.labri.fr ([147.210.8.143]:37078 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S965359AbWKNMYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:24:38 -0500
Message-ID: <4559B580.3070201@ens-lyon.org>
Date: Tue, 14 Nov 2006 13:24:32 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Monty Montgomery <monty@xiph.org>, Tejun Heo <htejun@gmail.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Douglas Gilbert <dougg@torque.net>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com> <20061110161510.GC15031@kernel.dk> <4554A681.2000502@ens-lyon.org> <20061110162330.GE15031@kernel.dk>
In-Reply-To: <20061110162330.GE15031@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried commit 616e8a091a035c0bd9b871695f4af191df123caa on top of
rc5 just in case. This commit fixes
http://lkml.org/lkml/2006/10/13/100, which looks related. And it
actually appears to fix our freeze too. Does this speak to you guys ?

Brice

