Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSDDGou>; Thu, 4 Apr 2002 01:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDDGol>; Thu, 4 Apr 2002 01:44:41 -0500
Received: from zok.sgi.com ([204.94.215.101]:1708 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S311180AbSDDGo0>;
	Thu, 4 Apr 2002 01:44:26 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tigran@aivazian.fsnet.co.uk (Tigran Aivazian),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules... 
In-Reply-To: Your message of "Wed, 03 Apr 2002 22:25:52 +0100."
             <E16ssGO-0004YM-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Apr 2002 16:43:19 +1000
Message-ID: <22511.1017902599@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002 22:25:52 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Ok, so that would cover the 2.5.x (and future stable) kernels. Does
>> Marcelo also agree that it should be the case in the 2.4.x kernel?
>
>Thats a Keith Owens question - will it break current modutils ? I think
>modutils compatibility for 2.4 must be sacrosanct

Trivial change to modutils, keeping backwards compatibility, so
EXPORT_SYMBOL_GPL == EXPORT_SYMBOL_INTERNAL.

When the flamers and lawyers agree on what they really mean by
EXPORT_SYMBOL_GPL or its replacement and everybody agrees on what the
keyword should be, let me know and I will roll a new modutils.
Otherwise, leave me out of this flamewar.

