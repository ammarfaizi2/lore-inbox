Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUFYBmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUFYBmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUFYBmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:42:09 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:51113 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266156AbUFYBl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:41:59 -0400
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
From: Jason Mancini <xorbe@sbcglobal.net>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040624150122.GB5068@apps.cwi.nl>
References: <1088073870.17691.8.camel@xorbe.dyndns.org>
	 <20040624150122.GB5068@apps.cwi.nl>
Content-Type: text/plain
Date: Thu, 24 Jun 2004 18:41:50 -0700
Message-Id: <1088127710.12345.1.camel@xorbe.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 17:01 +0200, Andries Brouwer wrote:
> More in particular, I read ISO 9660 section 7.3.3 as talking about
> unsigned integers. Only in 7.1.2 do signed integers occur.
> So, I suppose changing isonum_733 to return unsigned should suffice.
> 
> Could you test the below?
> 
> Andries

Ok I did, the patch seems to work great!  Thanks!
-Jason Mancini


