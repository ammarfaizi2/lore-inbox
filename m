Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUEZJw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUEZJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUEZJw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:52:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:59782 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265390AbUEZJw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:52:26 -0400
Date: Wed, 26 May 2004 11:52:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040526095222.GA12142@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405251655.43185.rob@landley.net> <20040525220826.GC1609@elf.ucw.cz> <200405251816.05497.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405251816.05497.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 18:16:05 -0500, Rob Landley wrote:
> 
> [a lot]

Sorry, you didn't have the time to make it short and I don't have the
time to read it all. ;)

Anyway, it sounds as if you really want a connect_files() or similar
that shortens a chain of pipes.  Similar to removing an element from a
doubly linked list.  Should be possible and not too hard either, iff
you can point to a decent user.

Right now, I don't care at all since it is just an optimization for
what's possible in userspace already and is rarely used.  Root of all
evil an such...

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
