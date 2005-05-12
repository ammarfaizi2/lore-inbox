Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVELGp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVELGp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVELGp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:45:57 -0400
Received: from mail.shareable.org ([81.29.64.88]:22993 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261155AbVELGpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:45:50 -0400
Date: Thu, 12 May 2005 07:45:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ram <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512064514.GA12315@mail.shareable.org>
References: <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a05051119181e53634e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> On 5/11/05, Jamie Lokier <jamie@shareable.org> wrote:
> > Please read carefully: I've described what _current_ kernels do.
> > 
> 
> I guess I misread when you wrote:

There are some things which you can't do with current kernels due to
the checks against current->namespace.  I'm not sure how important
those checks are.  And there are some things which you _can_ do, such
as passing directory file descriptors among processes which are in
different namespaces.

-- Jamie
