Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTGWVwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271337AbTGWVwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:52:30 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:1754 "HELO
	develer.com") by vger.kernel.org with SMTP id S271335AbTGWVw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:52:29 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: Thu, 24 Jul 2003 00:07:15 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com> <20030723193246.GA836@lst.de> <200307232357.25128.bernie@develer.com>
In-Reply-To: <200307232357.25128.bernie@develer.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307240007.15377.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 July 2003 23:57, Bernardo Innocenti wrote:

> NOTE: I just noticed the 2.4.x kernel was built with -O1 because I
> had symbolic debug enabled. That's not fair: 2.4.20 would probably
> come out even smaller than I reported!

Here come the numbers:

   text    data     bss     dec     hex filename
 640564   39152  134260  813976   c6b98 linux-2.4.x/linux-O1
 633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os


So the new comparison base is:

   text    data     bss     dec     hex filename
 633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
 819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
 ^^^^^^
       2.6 still needs a hard diet... :-/

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


