Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUG1QuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUG1QuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUG1QuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:50:10 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:32676 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267313AbUG1Qsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:48:43 -0400
Date: Wed, 28 Jul 2004 18:47:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728164733.GA30523@wohnheim.fh-wedel.de>
References: <20040728112222.GA7670@suse.de> <20040728152938.GM10891@smtp.west.cox.net> <20040728174213.GA7226@mars.ravnborg.org> <20040728155643.GO10891@smtp.west.cox.net> <20040728181817.GA14737@mars.ravnborg.org> <20040728163914.GQ10891@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040728163914.GQ10891@smtp.west.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 July 2004 09:39:14 -0700, Tom Rini wrote:
> 
> And, er, too early but I of course ment zlib_inflate, since we have the
> compressed image we need to uncompress..

If that works out, we should be able to kill lib/inflate.c as well.
That code is hopelessly outdated, has known bugs, etc.

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
