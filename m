Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUBGBZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbUBGBXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:23:34 -0500
Received: from mail.shareable.org ([81.29.64.88]:22480 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265801AbUBGBX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:23:29 -0500
Date: Sat, 7 Feb 2004 01:23:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nikolay Igotti <nike@lyola.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: memmove syscall
Message-ID: <20040207012319.GG12503@mail.shareable.org>
References: <Pine.LNX.4.44.0402052252130.5933-100000@chimarrao.boston.redhat.com> <40231BED.8060100@lyola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40231BED.8060100@lyola.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolay Igotti wrote:
>       mremap expands (or shrinks) an  existing  memory  mapping,  
> potentially
>       moving  it  at  the same time (controlled by the flags argument 
> and the
>       available virtual address space).
> 
> 
> And this syscall can be only used for realloc() kind of stuff, as you're 
> not allowed to change
> virtual address of some page to desired value,

Have you looked at the MREMAP_FIXED flag?

-- Jamie
