Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUHMXFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUHMXFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUHMXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:05:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49626 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267670AbUHMXFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:05:12 -0400
Subject: Re: [solved] binfmt_misc trouble with kernel 2.6.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Anand Buddhdev <anand@celtelplus.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092437540.803.22.camel@mindpipe>
References: <411CF503.40202@celtelplus.com>
	 <411D41DD.1080005@celtelplus.com>  <1092437540.803.22.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434570.25002.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:02:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 23:52, Lee Revell wrote:
> That is certainly a Fedora bug if they update a kernel package that
> requires userland configs to be updated and then don't update those
> configs. 

We've always not had an automount for that line. If there was an
automount it would keep loading that module for every user and 99.99999%
of the users don't care about or use binfmt_misc.

That's a decision that goes back to RH8 or so when binfmt_misc first
acquired its own file system.

Alan

