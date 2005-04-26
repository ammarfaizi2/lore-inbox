Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVDZKFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDZKFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDZKFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:05:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25008 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261443AbVDZKCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:02:46 -0400
Date: Tue, 26 Apr 2005 11:02:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426100241.GA30674@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu> <20050426095608.GA30554@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426095608.GA30554@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 10:56:08AM +0100, Christoph Hellwig wrote:
> On Tue, Apr 26, 2005 at 11:53:01AM +0200, Miklos Szeredi wrote:
> > No. FUSE is not a suid shell, and it's definitely not crap.  You are
> > being impolite and without a reason.  So don't be surprised if you get
> > burned.
> 
> You're model for user mounts is total crap.  The rest of the fuse kernel
> code is quite nice (1).

And btw, in case you think this flaming here is going to bring you forward
in any way:  it's not.  User mounts and namespace-related changes don't
belong into a lowelevel filesystem driver no matter what.  Whatever way
to handle user-private mount we're going to agree on it's not going to be
inside the fuse code.  So you're really better of stoppign the flaming,
stripping out those bits and help writing down a scheme that you'd want
to see in the VFS so we can see whether it makes sense and is implementable.
