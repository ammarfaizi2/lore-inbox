Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUCXS7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUCXS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:59:30 -0500
Received: from viefep19-int.chello.at ([213.46.255.28]:21544 "EHLO
	viefep19-int.chello.at") by vger.kernel.org with ESMTP
	id S263062AbUCXS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:59:29 -0500
Date: Wed, 24 Mar 2004 19:59:52 +0100
From: Andreas Theofilu <abfall@TheosSoft.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, jfs-discussion@www-124.southbury.usf.ibm.com
Subject: Re: kernel 2.6.4: Bug in JFS file system?
Message-Id: <20040324195952.7c1b625e.abfall@TheosSoft.net>
In-Reply-To: <1080135917.29044.80.camel@shaggy.austin.ibm.com>
References: <20040323195529.2ac9a207.andreas@TheosSoft.net>
	<1080135917.29044.80.camel@shaggy.austin.ibm.com>
Organization: Theos Soft
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 07:45:17 -0600
Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> Unfortunately, existing files with a non-zero high byte in a character
> are no longer accessible.  jfs should have printed a syslog message
> recommending that the file system be mounted with iocharset=utf8 to
> access the file.
> 
Thanks for that information. I didn't found any syslog message, but
mounting the partition with iocharset=utf8 brought back the previous
unaccessible files.Now everything is working fine again.

-- 
Andreas Theofilu
http://www.TheosSoft.net/

                     --==| Enjoy the science of Linux! |==--
