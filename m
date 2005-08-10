Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVHJLJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVHJLJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVHJLJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 07:09:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:39087 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S965066AbVHJLJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 07:09:42 -0400
Date: Wed, 10 Aug 2005 13:09:17 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050810110917.GG4634@marowsky-bree.de>
References: <20050802071828.GA11217@redhat.com> <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org> <20050810103041.GB4634@marowsky-bree.de> <20050810103256.GA6127@infradead.org> <20050810103424.GC4634@marowsky-bree.de> <20050810105450.GA6519@infradead.org> <20050810110259.GE4634@marowsky-bree.de> <20050810110511.GA6728@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050810110511.GA6728@infradead.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-08-10T12:05:11, Christoph Hellwig <hch@infradead.org> wrote:

> > What would a syntax look like which in your opinion does not remove
> > totally valid symlink targets for magic mushroom bullshit? Prefix with
> > // (which, according to POSIX, allows for implementation-defined
> > behaviour)? Something else, not allowed in a regular pathname?
> None.  just don't do it.  Use bindmount, they're cheap and have sane
> defined semtantics.

So for every directoy hiearchy on a shared filesystem, each user needs
to have the complete list of bindmounts needed, and automatically resync
that across all nodes when a new one is added or removed? And then have
that executed by root, because a regular user can't?

Sure. Very cheap and sane. I'm buying.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

