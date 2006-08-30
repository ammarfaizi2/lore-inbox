Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWH3N1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWH3N1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWH3N1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:27:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52453 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750824AbWH3N1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:27:34 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer  [try #2]
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 30 Aug 2006 15:23:17 +0200
References: <6Paqj-6iH-23@gated-at.bofh.it> <6NKRa-8sj-9@gated-at.bofh.it> <6Nv5K-8dh-9@gated-at.bofh.it> <6Nvfu-8t8-17@gated-at.bofh.it> <6NMJp-4wS-25@gated-at.bofh.it> <6PaTj-7vF-17@gated-at.bofh.it> <6PaTj-7vF-15@gated-at.bofh.it> <6Pciq-362-13@gated-at.bofh.it> <6PmUm-1Y7-9@gated-at.bofh.it> <6PwAr-6jv-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GIQ2c-0000h3-T8@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> "select" would not be needed if the configurator wouldn't make an option
> _invisible_ if it depends on another disabled option. It would be nice
> if the option would stay visible (or better yet, would be optionally
> visible) and had pointers to unfulfilled dependencies.
> 
> Or more generally spoken, "select" would not be needed if there were
> other means to switch the configurator's UI to a layout that exposes
> more details about dependencies. There is already such a UI mode which
> fully exposes _fulfilled_ dependencies.

The "options with pointers to (unfullfilled) dependencies" that should be
visible are (or should be) exactly the options now using select. In other
words, only make fooconfig needs to be enheanced.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
