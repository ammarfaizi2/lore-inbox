Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUIOVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUIOVwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUIOVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:49:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11716 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267523AbUIOVsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:48:36 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915214617.GA22361@hockin.org>
References: <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
	 <1095281358.23385.109.camel@betsy.boston.ximian.com>
	 <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com>
	 <1095283589.23385.117.camel@betsy.boston.ximian.com>
	 <20040915213526.GD25840@kroah.com>  <20040915214617.GA22361@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:47:36 -0400
Message-Id: <1095284856.23385.129.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:46 -0700, Tim Hockin wrote:

> The "big deal" is that namespaces are not *ever* considered when things
> like this go on.
> 
> We keep adding things that don't think namepsaces are a big deal, and
> we're painting ourselves into a corner where NONE of the advanced
> functionality will work in the face of namespaces.

This stuff does not break name spaces, though.  Not at all.  Root gets
the event and it or some user rescans their mount table.

I can use name spaces with this and they do not break.

You do have an argument with respect to the information leak, but I've
never looked at name spaces as a method of hiding what is mounted.

	Robert Love


