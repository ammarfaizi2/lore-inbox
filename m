Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVEQOJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEQOJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEQOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:09:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261216AbVEQOJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:09:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050516210815.GW27549@shell0.pdx.osdl.net> 
References: <20050516210815.GW27549@shell0.pdx.osdl.net>  <20050516184501.GD5112@stusta.de> 
To: Chris Wright <chrisw@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] security/: possible cleanups 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Tue, 17 May 2005 15:08:01 +0100
Message-ID: <17465.1116338881@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:

> I see no issue with the keys changes, except I'd rather see key_duplicate
> removed entirely if it's not getting used.  David, is there a plan to
> put it to use, or can Adrian remove it?

There was a keyctl call for it, I thought. I wonder what happened to it. Let
me think about what I want to do with it. Note that if key_duplicate() gets
removed, then the key_type->duplicate() op may as well be rooted out and shot
too.

The rest of the patch looks vaguely okay.

David
