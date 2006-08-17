Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWHQAJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWHQAJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWHQAJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:09:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46489 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932145AbWHQAJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:09:03 -0400
Subject: Re: + tty-trivial-kzalloc-opportunity.patch added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, alan@redhat.com
In-Reply-To: <9a8748490608161453y58c48fa8s5a64528d01192a84@mail.gmail.com>
References: <200608162142.k7GLgMYB013117@shell0.pdx.osdl.net>
	 <9a8748490608161453y58c48fa8s5a64528d01192a84@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 01:29:35 +0100
Message-Id: <1155774575.15195.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 23:53 +0200, ysgrifennodd Jesper Juhl:
> Let's get rid of the typecast - eh?

Sure

> Might as well also make the function inline given that all that's left
> of it is a single call to kzalloc() - and why not simply replace all
> calls to this function with a call to kzalloc()?

Because it will do other stuff in future, and because it has a free
function so the pairing is natural as an API.

Alan

