Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVHTTzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVHTTzN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVHTTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:55:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61153 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750950AbVHTTzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:55:12 -0400
Date: Sat, 20 Aug 2005 20:58:07 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@g5.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       g@parcelfarce.linux.theplanet.co.uk
Subject: Re: Fix up befs compile.
Message-ID: <20050820195807.GD29811@parcelfarce.linux.theplanet.co.uk>
References: <20050820194840.GA8455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820194840.GA8455@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 03:48:40PM -0400, Dave Jones wrote:
> fs/befs/linuxvfs.c:466: error: conflicting types for 'befs_follow_link'
> fs/befs/linuxvfs.c:44: error: previous declaration of 'befs_follow_link' was here
> fs/befs/linuxvfs.c: In function 'befs_follow_link':
> fs/befs/linuxvfs.c:490: warning: return makes integer from pointer without a cast
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 

It should be void *, not void.
