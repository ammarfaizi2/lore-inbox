Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTKQJOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTKQJOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:14:05 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:2052 "EHLO tartutest.cyber.ee")
	by vger.kernel.org with ESMTP id S263408AbTKQJOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:14:03 -0500
From: Meelis Roos <mroos@linux.ee>
To: xose@wanadoo.es, linux-kernel@vger.kernel.org, jes@wildopensource.com
Subject: Re: [summary] state of scsi drivers
In-Reply-To: <3FB7B181.5090001@wanadoo.es>
User-Agent: tin/1.7.2-20031104 ("Eriskay") (UNIX) (Linux/2.6.0-test9 (i686))
Message-Id: <E1ALfSJ-00025k-BB@rhn.tartu-labor>
Date: Mon, 17 Nov 2003 11:13:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XVP> o qla1280
XVP>    manufacturer: QLOGIC
XVP>    kernel: 3.23.37
XVP>    latest: 3.23.37
XVP>    arch: i386 alpha powerpc sparc
XVP>    maintainer: <jes*AT*wildopensource.com>
XVP>    url: -

qla1280 doesn't work on sparc (neither 2.4 nor 2.6) since it uses
flush_cache_all symbol from MM internals and there's no such internal
function on sparc.

-- 
Meelis Roos
