Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUIOVt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUIOVt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUIOVsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:48:15 -0400
Received: from [66.35.79.110] ([66.35.79.110]:44741 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267595AbUIOVqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:46:24 -0400
Date: Wed, 15 Sep 2004 14:46:17 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@novell.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915214617.GA22361@hockin.org>
References: <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <20040915213526.GD25840@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915213526.GD25840@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:35:26PM -0700, Greg KH wrote:
> Hm, this is an issue that I and the FreeBSD author of jail were talking
> about a week or so ago when I was describing why we did udev in
> userspace and the hotplug stuff.  He pointed out the namespace issue as
> the biggest problem for FreeBSD to be able to do the same kind of thing
> that we are doing.
> 
> But I agree, I don't think it's a big deal right now either.

The "big deal" is that namespaces are not *ever* considered when things
like this go on.

We keep adding things that don't think namepsaces are a big deal, and
we're painting ourselves into a corner where NONE of the advanced
functionality will work in the face of namespaces.

