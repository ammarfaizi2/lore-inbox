Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTENFJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTENFJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:09:44 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:41253 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261301AbTENFJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:09:43 -0400
Date: Tue, 13 May 2003 22:23:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: andyp@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][2.5.69] Re: Updated kexec diffs...
Message-Id: <20030513222343.74a3d817.akpm@digeo.com>
In-Reply-To: <m1k7cu3yey.fsf@frodo.biederman.org>
References: <3EBA626E.6040205@cyberone.com.au>
	<20030508121211.532dcbcf.akpm@digeo.com>
	<3EBC37C4.9090602@cyberone.com.au>
	<20030509162911.2cd5321e.akpm@digeo.com>
	<m1u1c37d2o.fsf@frodo.biederman.org>
	<20030509201327.734caf9e.akpm@digeo.com>
	<m1of2978ao.fsf@frodo.biederman.org>
	<20030511121753.7a883afb.akpm@digeo.com>
	<m1fznl57ss.fsf_-_@frodo.biederman.org>
	<1052861167.1324.15.camel@andyp.pdx.osdl.net>
	<m1k7cu3yey.fsf@frodo.biederman.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 05:22:26.0161 (UTC) FILETIME=[CE51E610:01C319D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> And Andrew has it in 2.5.69-mm4 and is busy pestering me about compile
>  errors. 

I'm like that.

I've dropped out a lot of the NORET stuff.  It generates warnings on all
other architectures, because their machine_restart, machine_halt and
machine_power_off definitions don't have necessary attributes and don't
have the while(1); at the end.


