Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIOU6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIOU6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUIOU4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:56:52 -0400
Received: from [66.35.79.110] ([66.35.79.110]:60356 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267466AbUIOUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:48:09 -0400
Date: Wed, 15 Sep 2004 13:47:54 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915204754.GA19625@hockin.org>
References: <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095280414.23385.108.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:33:34PM -0400, Robert Love wrote:
> > In which namespace?  All of them?  Is that an information leak that might
> > be hazardous (I'm bad with security stuff).
> 
> You can only see your own namespace.  So e.g. /proc/mtab is your name
> space's mount table and you can rescan that when receiving the mount
> signal.

> So there is no information leak.

Are you not sending it with some specific device as the source?  Or is it
just coming from some abstract root kobject?
