Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTDSWKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDSWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:10:10 -0400
Received: from [12.47.58.203] ([12.47.58.203]:40662 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263484AbTDSWKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:10:10 -0400
Date: Sat, 19 Apr 2003 15:22:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Private namespaces
Message-Id: <20030419152214.3f237b12.akpm@digeo.com>
In-Reply-To: <UTC200304192218.h3JMIak17446.aeb@smtp.cwi.nl>
References: <UTC200304192218.h3JMIak17446.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 22:22:04.0713 (UTC) FILETIME=[1B405990:01C306C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Concerning style - I don't like
> 
> 	if ((retval = copy_sighand(clone_flags, p)))
> 
> very much.

Me either.  But in this case there are so darn many of them it seems
acceptable.

