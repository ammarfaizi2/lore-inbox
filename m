Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVITHqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVITHqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVITHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:46:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40646 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964905AbVITHqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:46:07 -0400
Subject: Re: [RFC PATCH 4/10] vfs: global namespace semaphore
From: Ram Pai <linuxram@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
In-Reply-To: <20050920065142.GH7992@ftp.linux.org.uk>
References: <20050916182619.GA28474@RAM>
	 <20050920065142.GH7992@ftp.linux.org.uk>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1127202362.10061.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Sep 2005 00:46:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 23:51, Al Viro wrote:
> On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> > This patch removes the per-namespace semaphore in favor of a global
> > semaphore.  This can have an effect on namespace scalability.
> 
> ... and #2 uses that semaphore...

Patch #2, uses the global semaphore.  Yes that patch  would'nt have
compiled without patch #4, because the global semaphore got defined only
in the patch #4.

RP

