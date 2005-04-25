Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVDYVaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDYVaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDYVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:30:18 -0400
Received: from smtp.istop.com ([66.11.167.126]:16297 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261226AbVDYV1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:27:52 -0400
From: Daniel Phillips <phillips@istop.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 5/7] dlm: device interface
Date: Mon, 25 Apr 2005 17:27:58 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050425151303.GF6826@redhat.com> <Pine.LNX.4.62.0504251754330.2941@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504251754330.2941@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251727.58644.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 12:09, Jesper Juhl wrote:
> On Mon, 25 Apr 2005, David Teigland wrote:
> > +/* Close on control device */
> > +static int dlm_ctl_close(struct inode *inode, struct file *file)
> > +{
> > + return 0;
> > +}
>
> return void? and what's the purpose of this function? seems silly to me to
> have a function that does nothing but return 0 ever.

How about just adding "inline" calling it "documentation"?

Regards,

Daniel
