Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTHZTQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTHZTQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:16:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:45829 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262671AbTHZTQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:16:05 -0400
Subject: Re: 2.6.0-test4 and /etc/modules.conf
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: cijoml@volny.cz
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308261748.20002.cijoml@volny.cz>
References: <200308252332.46101.cijoml@volny.cz>
	 <200308261428.07929.cijoml@volny.cz> <20030826123312.GD7038@fs.tum.de>
	 <200308261748.20002.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1061925361.686.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 21:16:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 17:48, Michal Semler (volny.cz) wrote:

> I have in /etc/modules.conf defined which modules to use. 2.4.22 uses it well, 
> but 2.6.0-test4 doesn't.

I assume you are using the corresponding updated modutils package that
is compatible with 2.6 kernels. This new modutils package uses
/etc/modprobe.conf instead of the old /etc/modules.conf.

Since both files are almost compatible, you can safely copy the contents
of /etc/modules.conf to /etc/modprobe.conf.

