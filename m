Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTDGQuW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTDGQuV (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:50:21 -0400
Received: from ns.javad.ru ([62.105.138.7]:12813 "EHLO ns.javad.ru")
	by vger.kernel.org with ESMTP id S263516AbTDGQuV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:50:21 -0400
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modifying line state manually on ttyS
References: <200304071702.08114.freesoftwaredeveloper@web.de>
	<87d6jyiany.fsf@osv.javad.ru>
	<200304071832.20627.freesoftwaredeveloper@web.de>
X-attribution: osv
From: Sergei Organov <osv@javad.ru>
Date: 07 Apr 2003 21:01:58 +0400
In-Reply-To: <200304071832.20627.freesoftwaredeveloper@web.de>
Message-ID: <877ka6i6m1.fsf@osv.javad.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <freesoftwaredeveloper@web.de> writes:
> On Monday 07 April 2003 17:34, Sergei Organov wrote:
> > Do ioctl(fd, TIOCSBRK, 0) / ioctl(fd, TIOCSBRK, 0) help?
> 
> What does it do? I haven't found a description for TIOCSBRK, TIOCSBRK.

Changes the state of TxD line, I believe. Did you hear about "break
condition"? It sets/clears the "break condition", at least for me ;)

-- 
Sergei.



