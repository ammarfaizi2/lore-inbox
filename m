Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVDLOlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVDLOlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDLOgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:36:48 -0400
Received: from mail.shareable.org ([81.29.64.88]:11936 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262254AbVDLOeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:34:00 -0400
Date: Tue, 12 Apr 2005 15:33:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412143347.GC10995@mail.shareable.org>
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > It would also be nice to generalise and have virtual filesystems which
> > are able to present different views to different users.  Can FUSE do
> > that already - is the userspace part told which user is doing each
> > operation?
> 
> Yes.
> 
> > With that, the desire for virtual filesystems which cannot be read
> > by your sysadmin (by accident) is easy to satisfy - and that kind of
> > mechanism would probably be acceptable to all.
> 
> The problem is that this way the responsibility goes to the userspace
> program, which can't be trusted.

That does not make sense.

Are you saying you cannot trust your own sshfs userspace daemon?

-- Jamie
