Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUJNSzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUJNSzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUJNSwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:52:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:31205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267291AbUJNScX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:32:23 -0400
Date: Thu, 14 Oct 2004 11:32:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Love <rml@novell.com>
cc: Jeff Garzik <jgarzik@pobox.com>, "Timothy D. Witham" <wookie@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Announcing Binary Compatibility/Testing
In-Reply-To: <1097709855.5411.20.camel@localhost>
Message-ID: <Pine.LNX.4.58.0410141129200.3897@ppc970.osdl.org>
References: <1097705813.6077.52.camel@wookie-zd7>  <416DAEB7.4050108@pobox.com>
 <1097709855.5411.20.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Oct 2004, Robert Love wrote:
> 
> Any other incompatibility lies in libraries, but we have library
> versioning.

No we don't.

Yes, we "have the technology". But it's not actually used for libc (which
is most of the problematic stuff), so we do not actually have library
versioning.

Instead, glibc tries very hard to be binary compatible, and invariably 
fails occasionally. 

Oh, well.

		Linus
