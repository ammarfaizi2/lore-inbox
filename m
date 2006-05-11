Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWEKQSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWEKQSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWEKQSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:18:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2502 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030317AbWEKQSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:18:48 -0400
Date: Thu, 11 May 2006 17:18:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>, linux-kernel@vger.kernel.org
Subject: Re: fix compiler warning in ip_nat_standalone.c
Message-ID: <20060511161846.GM27946@ftp.linux.org.uk>
References: <200605111729.48871.Rik.Bobbaers@cc.kuleuven.be> <20060511155537.GF1104@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511155537.GF1104@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 05:55:37PM +0200, J?rn Engel wrote:
> On Thu, 11 May 2006 17:29:48 +0200, Rik Bobbaers wrote:
> > 
> > i just made small patch that fixes a compiler warning:
> 
> Just in case Al didn't make it clear enough in the recent thread:
> 
> You cannot fix a compiler warning!
> 
> Either the code is wrong or it is right.  A compiler warning can
> indicate that code is wrong, or it is a false positive.  If the code
> is wrong, fix the _code_.

Which is what the patch does, AFAICS.  What's the problem in this case?
