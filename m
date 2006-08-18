Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWHRKdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWHRKdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHRKdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:33:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7318 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751347AbWHRKdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:33:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060818083911.GB7516@ucw.cz> 
References: <20060818083911.GB7516@ucw.cz>  <p734pwea07b.fsf@verdi.suse.de> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com> <7510.1155630597@warthog.cambridge.redhat.com> 
To: Pavel Machek <pavel@suse.cz>
Cc: David Howells <dhowells@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus ops for gcc 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 18 Aug 2006 11:33:08 +0100
Message-ID: <4341.1155897188@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:

> > There are places where the compiler emits these that aren't entirely
> > obvious, one of which IIRC is in ext2 inode allocation.
> 
> Well -- but that is good reason to keep that open-coded, right?

Maybe.  I'm not sure I agree, but Linus is permitted to have differing
opinions.

Anyway, that set of patches has been superseded since Al didn't want it done
that way.

David
