Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTE2PuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTE2PuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:50:21 -0400
Received: from verein.lst.de ([212.34.189.10]:9432 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262318AbTE2PuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:50:20 -0400
Date: Thu, 29 May 2003 18:03:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "H. J. Lu" <hjl@lucon.org>
Cc: ismail donmez <voidcartman@yahoo.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Message-ID: <20030529160326.GB19751@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, "H. J. Lu" <hjl@lucon.org>,
	ismail donmez <voidcartman@yahoo.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <20030529150446.99966.qmail@web41011.mail.yahoo.com> <20030529084948.A30796@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529084948.A30796@lucon.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 08:49:48AM -0700, H. J. Lu wrote:
> This is a kernel issue and should be fixed in kernel unless we want
> to do something in <sys/sysctl.h>.

You should not include kernel headers from userspace.

