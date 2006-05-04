Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWEDJio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWEDJio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEDJin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:38:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19727 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751463AbWEDJiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:38:25 -0400
Date: Thu, 4 May 2006 07:28:49 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1.6
Message-ID: <20060504072849.GC5359@ucw.cz>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> processing the 4096-byte extents. The second modification is that the
> header region occupies either 8192 bytes or the page size of the host
> on which the file is created, whichever is larger. This maximizes the
> probability that pages will be aligned between the unencrypted and
> encrypted data, which is not a requirement, but it helps with
> performance.

Does that mean that 10-bytes file now occupies 12KB disk space in
common case of 4K filesystem?
							Pavel
-- 
Thanks, Sharp!
