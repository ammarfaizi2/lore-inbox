Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTDWQrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTDWQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:47:34 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:57773 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S264121AbTDWQrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:47:31 -0400
Date: Wed, 23 Apr 2003 18:59:31 +0200
From: Frank v Waveren <fvw@var.cx>
To: Werner Almesberger <wa@almesberger.net>
Cc: Robert Love <rml@tech9.net>, Julien Oster <frodo@dereference.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <1051117076FZS.fvw@jareth.var.cx>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net> <20030423160556.GA30306@frodo.midearth.frodoid.org> <20030423134530.C3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423134530.C3557@almesberger.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 01:45:30PM -0300, Werner Almesberger wrote:
> Yes, but you'll get quite a few objections to adding yet another
> suid root program :-)

Why not make it mode 440, and have a mount option for the proc
filesystem that gives which gid certain sensitive files should have.
The openwall security patch does this (with a few further restrictions
to the permissions of certain /proc files) and I like it a lot.

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|chello.nl] ICQ#10074100            1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
