Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUJAFgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUJAFgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269709AbUJAFgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:36:06 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20421 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269703AbUJAFfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:35:18 -0400
Subject: Re: [patch] inotify: make user visible types portable
From: Robert Love <rml@novell.com>
To: Paul Jackson <pj@sgi.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040930155704.16d71cec.pj@sgi.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096583108.4203.86.camel@betsy.boston.ximian.com>
	 <20040930155704.16d71cec.pj@sgi.com>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 01:35:25 -0400
Message-Id: <1096608925.4803.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 15:57 -0700, Paul Jackson wrote:

> Why not "u32"?

The rule is to use the __foo variants for externally viewable types.

Indeed, the examples you gave are wrapped in __KERNEL__.

Best,

	Robert Love


