Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbUJ1TFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUJ1TFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUJ1TFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:05:02 -0400
Received: from quechua.inka.de ([193.197.184.2]:47792 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261980AbUJ1TAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:00:44 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041028170642.GA8220@thunk.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CNFVq-0001mo-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 28 Oct 2004 21:00:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041028170642.GA8220@thunk.org> you wrote:
> But directory sizes are unlimited --- they could conceivably be
> hundreds of megabytes, and so it's not reasonable to require the
> kernel to do the snapshot using unpageable kernel memory.

Well, I guess that  what COW or Versioning is for. Another option would be a
optimistic locking readdir alternative (or usage of fam-like events in
addition).

Gruss
Bernd
