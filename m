Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311613AbSCNNOb>; Thu, 14 Mar 2002 08:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311614AbSCNNOX>; Thu, 14 Mar 2002 08:14:23 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:17139 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S311613AbSCNNOO>; Thu, 14 Mar 2002 08:14:14 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0203141219180.1643-100000@einstein.homenet> 
In-Reply-To: <Pine.LNX.4.33.0203141219180.1643-100000@einstein.homenet> 
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@bytesex.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>, arjan@fenrus.demon.nl
Subject: Re: [patch] vmalloc_to_page() backport for 2.4 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Mar 2002 13:13:12 +0000
Message-ID: <25104.1016111592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tigran@veritas.com said:
> And, as such, it suggests that the _GPL bit in the export clause is
> not justified and should be removed. There is no reason whatsoever why
> Linux base kernel should allow some useful functionality to GPL
> modules and disallow the same to non-GPL ones.

You offer no reason why the routine in question _should_ be exported for use
by binary-only modules. EXPORT_SYMBOL_GPL() was invented to allow authors of
code to make their intentions clear; if you disagree with the decision in
this case then either take it up in private with the author of this code, or
switch to BSD, which doesn't suffer from this pesky GPL-thingy.

--
dwmw2


