Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUEUXOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUEUXOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUEUXJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:09:14 -0400
Received: from mail.zrz.TU-Berlin.DE ([130.149.4.15]:38841 "EHLO
	mail.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S264853AbUEUXFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:05:49 -0400
Date: Sat, 22 May 2004 01:05:45 +0200
From: Andreas Amann <amann@physik.tu-berlin.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Message-ID: <20040521230545.GA787@bill.physik.tu-berlin.de>
References: <200405131411.52336.amann@physik.tu-berlin.de> <200405171331.35688.amann@physik.tu-berlin.de> <1084809309.3669.17.camel@lade.trondhjem.org> <200405211727.14917.amann@physik.tu-berlin.de> <1085157602.3666.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085157602.3666.70.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 12:40:02PM -0400, Trond Myklebust wrote:
> 
> Hmm... It looks to me as if you are exporting that filesystem with the
> "subtree_check" option enabled. Could you try to set "no_subtree_check"?

Thanks for that one, with "no_subtree_check" the problem disappears!
What is the disadvantage of this option?


Andreas

