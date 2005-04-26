Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVDZJ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVDZJ5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDZJ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:57:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14256 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261450AbVDZJ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:56:11 -0400
Date: Tue, 26 Apr 2005 10:56:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426095608.GA30554@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:53:01AM +0200, Miklos Szeredi wrote:
> No. FUSE is not a suid shell, and it's definitely not crap.  You are
> being impolite and without a reason.  So don't be surprised if you get
> burned.

You're model for user mounts is total crap.  The rest of the fuse kernel
code is quite nice (1).

> > You're really falling into the Hans Reiser trap - if you just wanted to
> > add a simple userland filesystem you'd be done by now, but you're trying
> > to funnel new semantics in through it.  Which is by far not as easy as
> > adding a simple file system driver and needs a lot more though.  
> 
> I've started FUSE in 2001.  Did you think it was easy getting this far?

And that matters how exactly?


(1) except the rather fishy get_user_pages variant.  but I'm not expert
enough there to comment more
