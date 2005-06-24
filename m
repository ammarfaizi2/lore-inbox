Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVFXOoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVFXOoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFXOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:44:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19073 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262080AbVFXOn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:43:58 -0400
Date: Fri, 24 Jun 2005 15:45:23 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Alexander Zarochentcev <zam@namesys.com>, Lincoln Dale <ltd@cisco.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050624144522.GR29811@parcelfarce.linux.theplanet.co.uk>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <42BB7083.2070107@cisco.com> <42BBAD0F.2040802@namesys.com> <20050624071159.GQ29811@parcelfarce.linux.theplanet.co.uk> <42BBCC65.8060709@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBCC65.8060709@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 02:03:33AM -0700, Hans Reiser wrote:
> Al Viro wrote:
> 
> >Have I missed the posting with analysis of changes in locking scheme
> >and update of proof of correctness?  If so, please give the message ID.
> >
> >_That_ had been the major showstopper for any merges, IIRC.
> >  
> >
> Ah, the prince of helpfulness has arrived.
> 
> Yes, as I remember,

Kindly put some efforts into remembering the thread that contains e.g.
http://marc.theaimsgroup.com/?l=linux-kernel&m=109347094309283&w=2

If that work (summary: introduction of hybrid objects invalidates the
existing locking scheme for directories and that had lead at least to
several user-exploitable deadlocks described in details in the same
thread; current proof of correctness is in the tree, see
Documentation/filesystems/Directory-Locking.txt and at the very least
it needs to be updated) had been done - please, give the message ID
of posting with such update.  If not - please, arrange getting it done.
