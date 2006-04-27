Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWD0NFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWD0NFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWD0NFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:05:05 -0400
Received: from mail.ccur.com ([66.10.65.12]:54121 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S965026AbWD0NFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:05:04 -0400
Subject: Re: CLONE_NEWNS and mount command?
From: Tom Horsley <tom.horsley@ccur.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bugsy <bugsy@ccur.com>
In-Reply-To: <20060427130149.GP27946@ftp.linux.org.uk>
References: <1146142640.23667.9.camel@tweety>
	 <20060427130149.GP27946@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Apr 2006 09:05:02 -0400
Message-Id: <1146143102.23667.11.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 14:01 +0100, Al Viro wrote:
> Huh?  a) /proc/mounts is the list for namespace of one who'd opened it
> (it's a symlink to /proc/self/mounts).  b) are you sure that you do
> not simply end up with chewing shared /etc/mtab?

Very possible if there really is an mtab file these days. I was
sorta hoping that the mount command used the /proc/mounts. I should
do my experiment again looking only at /proc/mounts I guess.

If there is a bug, maybe it is that a /etc/mtab file exists
at all :-).

