Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUIAUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUIAUDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIAT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:57:49 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:55070 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267517AbUIATyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:54:38 -0400
Date: Wed, 1 Sep 2004 21:56:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] kbuild - remove old LDFLAGS_BLOB from Makefiles.
Message-ID: <20040901195648.GB15432@mars.ravnborg.org>
Mail-Followup-To: blaisorblade_spam@yahoo.it, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040830194430.30C042C6E@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830194430.30C042C6E@zion.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:44:30PM +0200, blaisorblade_spam@yahoo.it wrote:
> 
> The LDFLAGS_BLOB var (which used to be defined in arch Makefiles) is now unused,
> as specified inside usr/initramfs_data.S. So this patch removes the remaining
> references.
> 
> A separate patch is provided to remove it from UML, and another to update docs.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Thanks.

Your patches caused rejects in my tree, so I applied them
by hand as a single patch.

In makefiles.txt I just removed the LDFLAGS_BLOB section.

	Sam

