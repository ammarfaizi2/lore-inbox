Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVIPV3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVIPV3g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIPV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:29:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27067 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750907AbVIPV3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:29:34 -0400
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@ftp.linux.org.uk,
       Miklos Szeredi <miklos@szeredi.hu>, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
In-Reply-To: <20050916205533.GB20966@kvack.org>
References: <20050916182619.GA28428@RAM>  <20050916205533.GB20966@kvack.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1126906164.4693.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Sep 2005 14:29:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 13:55, Benjamin LaHaise wrote:
> On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> > -static void *m_start(struct seq_file *m, loff_t *pos)
> > +static void *m_start(struct seq_file *m, loff_t * pos)
> 
> This is wrong, probably an lindent bug.

Yes it is a lindent bug. 
Will fix manually.
RP


