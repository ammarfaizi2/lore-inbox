Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbTICXJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTICXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:09:45 -0400
Received: from smtp.terra.es ([213.4.129.129]:56627 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S264295AbTICXJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:09:44 -0400
Date: Thu, 4 Sep 2003 01:08:52 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-Id: <20030904010852.095e7545.diegocg@teleline.es>
In-Reply-To: <20030902231812.03fae13f.akpm@osdl.org>
References: <20030902231812.03fae13f.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 2 Sep 2003 23:18:12 -0700 Andrew Morton <akpm@osdl.org> escribió:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
> 
> . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
>   in evaluating the stability, efficacy and relative performance of Nick's
>   work.
> 
>   We're looking for feedback on the subjective behaviour and on the usual
>   server benchmarks please.


I must say that this one doesn't feel nice under heavy gcc load. Huge mp3
skips that didn't happened before, big pauses in X...gcc starves anything else.
-mm4 was better there.
