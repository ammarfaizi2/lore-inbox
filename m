Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVDZJwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVDZJwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVDZJuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:50:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4784 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261446AbVDZJrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:47:35 -0400
Date: Tue, 26 Apr 2005 10:47:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426094727.GA30379@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:41:00AM +0200, Miklos Szeredi wrote:
> Christoph, you are being thickheaded, and this is not the first time.
> Please go away.

Please stop the flaming.  You're adding the equivalent of "I've added
a suid shell, please make sure it can only affect the caller's files".

Do you really think we want to add such crap?

You're really falling into the Hans Reiser trap - if you just wanted to
add a simple userland filesystem you'd be done by now, but you're trying
to funnel new semantics in through it.  Which is by far not as easy as
adding a simple file system driver and needs a lot more though.  

