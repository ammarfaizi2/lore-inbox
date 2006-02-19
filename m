Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWBSUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWBSUXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWBSUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:23:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751011AbWBSUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:23:21 -0500
Subject: Re: Determine Files or Blocks in Page Cache
From: Arjan van de Ven <arjan@infradead.org>
To: Chase Douglas <cndougla@purdue.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43F8D0D6.2080603@purdue.edu>
References: <43F8D0D6.2080603@purdue.edu>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 21:20:09 +0100
Message-Id: <1140380410.6514.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 15:11 -0500, Chase Douglas wrote:
> I'm doing some research with servers and would like to know if there's 
> any reasonable way to determine which files or blocks of files are being 
> cached at any given time. 

which files is hard currently; which blocks of a file you can get by
mmaping the file and then using the mincore() syscall..

