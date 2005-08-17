Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVHQDS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVHQDS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVHQDS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:18:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:54714 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750806AbVHQDS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:18:57 -0400
Subject: Re: compiling only one module in kernel version 2.6?
From: Steven Rostedt <rostedt@goodmis.org>
To: Fong Vang <sudoyang@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4f52331f050816190957cec081@mail.gmail.com>
References: <4f52331f050816190957cec081@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 23:18:49 -0400
Message-Id: <1124248729.5764.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 19:09 -0700, Fong Vang wrote:
> What's the easiest way to compile just one module in the Linux 2.6 kernel tree?
> 
> This no longer seem to work:
> 
>   $ cd /usr/src/linux
>   $ make SUBDIRS=fs/reiserfs modules
>            Building modules, stage 2.
>            MODPOST
> 
>   I don't see any .ko generated.

It worked for me. Is your reiserfs turned on as a module, and not
compiled into the kernel. (<M> not <*> nor < >)

-- Steve


