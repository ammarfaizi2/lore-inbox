Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWCJIBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWCJIBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCJIBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:01:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61900 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751135AbWCJIBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:01:40 -0500
Subject: Re: How can I link the kernel with libgcc ?
From: Arjan van de Ven <arjan@infradead.org>
To: Carlos Munoz <carlos@kenati.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4410EC0D.3090303@kenati.com>
References: <4410D9F0.6010707@kenati.com>
	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
	 <1141956362.13319.105.camel@mindpipe>  <4410EC0D.3090303@kenati.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 09:01:35 +0100
Message-Id: <1141977696.2876.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately, the driver needs to populate several coefficient tables 
> for the hardware to perform silence suppression and other advance 
> features. The values for these tables are calculated using log10 
> operations. I don't  see a clean way to push these operations to user 
> space without the need for custom applications that build the tables and 
> pass them to the driver.


can you calculate these at build time instead and store it as a table in
the .c file ?

