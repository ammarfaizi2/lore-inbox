Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273227AbTG3Sgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273228AbTG3Sgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:36:36 -0400
Received: from dp.samba.org ([66.70.73.150]:31398 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S273227AbTG3Sgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:36:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Bas Mevissen <ml@basmevissen.nl>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules. 
In-reply-to: Your message of "Wed, 30 Jul 2003 12:15:18 +0200."
             <20030730101518.GL4279@louise.pinerecords.com> 
Date: Thu, 31 Jul 2003 02:46:23 +1000
Message-Id: <20030730183635.0B82D2C097@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030730101518.GL4279@louise.pinerecords.com> you write:
> > [ml@basmevissen.nl]
> > 
> > >The possibility of compressing the modules is interesting, like for
> > >example in cases of construction of small systems or initrd.
> > 
> > In both cases, you might use a compressed file system. Maybe you better 
> > try to save memory and disk space by compressing less critical stuff 
> > than kernel modules.
> 
> It's a valid feature request nonetheless.

I agree, but I believe almost anything is a valid feature request.

I don't want to require zlib, though.  The modutils I have (Debian)
doesn't support it, either.

It's fairly trivial patch, which probably is best as an add-on (which
I think RH do?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
