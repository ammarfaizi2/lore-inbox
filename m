Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUEUNno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUEUNno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 09:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbUEUNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 09:43:44 -0400
Received: from mail1.kontent.de ([81.88.34.36]:28125 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265841AbUEUNnn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 09:43:43 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Date: Fri, 21 May 2004 15:42:40 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org>
In-Reply-To: <40ADF605.2040809@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405211542.40587.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Mai 2004 14:28 schrieb Nigel Cunningham:
> > Kernel threads are different, and each must be handled separately,
> > maybe even with some ordering. But there's relatively small number of
> > kernel threads... 
> 
> Yes, but what order? I played with that problem for ages. Perhaps I just 
>   didn't find the right combination.

How about recording the order of creation and do it in opposite order?

	Regards
		Oliver

