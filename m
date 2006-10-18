Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422744AbWJRSCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422744AbWJRSCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWJRSCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:02:42 -0400
Received: from mail.fieldses.org ([66.93.2.214]:30132 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1422744AbWJRSCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:02:41 -0400
Date: Wed, 18 Oct 2006 14:02:33 -0400
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Sven Hoexter <shoexter@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
Message-ID: <20061018180233.GF5374@fieldses.org>
References: <4534F59D.4040505@gmail.com> <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org> <4535EB4F.4070406@gmail.com> <45364C51.2000004@gmail.com> <1161192121.6095.58.camel@lade.trondhjem.org> <453667F1.4040504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453667F1.4040504@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 07:44:17PM +0200, Jiri Slaby wrote:
> Trond Myklebust wrote:
> >I'll bet that you have always had a subdirectory of the exact same
> >filesystem mounted somewhere else ro, right?
> 
> Yup, exactly: /usr -ro and /home -rw on the same (hda3) partition.

Just out of curiosity--why are you doing that?

On the linux server, at least, that doesn't really prevent writing to
/usr unless you've also turned on subtree checking.  And subtree
checking causes other problems.

--b.
