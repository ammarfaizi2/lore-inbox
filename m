Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTIYLZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTIYLZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:25:18 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:62892 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261801AbTIYLZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:25:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 25 Sep 2003 13:25:07 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: linux/time.h annoyance
Message-ID: <20030925112507.GA6212@bytesex.org>
References: <1064483200.6405.442.camel@shrek.bitfreak.net> <20030925105436.A8809@infradead.org> <1064485031.2220.468.camel@shrek.bitfreak.net> <20030925112326.A9412@infradead.org> <1064487333.2228.475.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064487333.2228.475.camel@shrek.bitfreak.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you ask Gerd nicely he might even include that change in the kernel
> > version so don't have to keep a delta.
> 
> Hm, makes sense... Gerd, could you please remove linux/time.h from
> linux/videodev2.h?

I can't remove it, it will break in kernel space then.  But my latest
version has it #ifdef'ed already (patches at bytesex.org/patches, as
usual ...).

  Gerd

-- 
You have a new virus in /var/mail/kraxel
