Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbTGCAcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 20:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbTGCAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 20:32:38 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:22243 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265997AbTGCAch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 20:32:37 -0400
Subject: Re: build from RO source tree?
From: david nicol <whatever@davidnicol.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0307021615150.15047-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307021615150.15047-100000@vervain.sonytel.be>
Content-Type: text/plain
Organization: 
Message-Id: <1057193186.966.17.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jul 2003 19:46:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-02 at 09:15, Geert Uytterhoeven wrote:

> Subject: [PATCH] touchless dependencies for 2.4.x
> 
> 	Hi,
> 
> The 2.4.x dependency system depends on being able to `touch' include files in
> case of recursive dependencies.  This fails when using a revision control
> system (e.g. ClearCase) where non-checked out files are read-only and cannot be
> touch'ed.
> 
> The patch below solves this by making object files depend on (recursive) lists,
> containing the list of dependencies for each header file.

So with this patch applied you can safely build in a lndir against
a RO media. but without it you can't?  



-- 
David Nicol, independent consultant, contractor, and food service worker

