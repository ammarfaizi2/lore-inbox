Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSB0TMm>; Wed, 27 Feb 2002 14:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292894AbSB0TMW>; Wed, 27 Feb 2002 14:12:22 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:9089 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S292839AbSB0TKK>; Wed, 27 Feb 2002 14:10:10 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Wed, 27 Feb 2002 11:10:08 -0800
From: dhinds <dhinds@sonic.net>
To: linux-kernel@vger.kernel.org
Cc: flood@flood-net.de
Subject: Re: pcmcia problems with IDE & cardbus
Message-ID: <20020227111008.A13182@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Roedl wrote:

> Apart from your problem I finally found out that all dldwd_* stuff in 2.4.18 
> has been renamed to orinoco_*, so pcmcia-3.1.31 is not usable with 2.4.18... 

Err what?

Why would the names of functions in the orinoco_cs driver affect the
usability of the pcmcia-cs package on a particular kernel?

I think you're doing something wrong.  The only circumstance I could
imagine this making a difference is if you're trying to mix some of
the orinoco modules from the kernel tree with other orinoco modules
from the pcmcia-cs tree.

-- Dave

