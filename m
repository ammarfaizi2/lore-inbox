Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUIOUbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUIOUbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIOU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:28:53 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20163 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267388AbUIOU10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:27:26 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915202234.GA18242@hockin.org>
References: <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 16:26:25 -0400
Message-Id: <1095279985.23385.104.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:22 -0700, Tim Hockin wrote:

> So do we actually plan to handle namespaces at all wrt kevents?

I don't see why we have to.

A mount event should really just cause a rescan of the mount table.

	Robert Love


