Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWBTKic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWBTKic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWBTKic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:38:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23447 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964859AbWBTKib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:38:31 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4993.1140431092@warthog.cambridge.redhat.com> 
References: <4993.1140431092@warthog.cambridge.redhat.com>  <20060218161122.f9d588fb.davi.arnaut@gmail.com> <20060218113602.edc06ce5.davi.arnaut@gmail.com> <3487.1140281089@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Davi Arnaut <davi.arnaut@gmail.com>, akpm@osdl.org, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl) 
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 20 Feb 2006 10:38:16 +0000
Message-ID: <5378.1140431896@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > I think you should just tell Andrew to drop
> > keys-deal-properly-with-strnlen_user.patch
> > in favor of mine... :-)
> 
> No... you've taken out all the checks on lengths on NUL-terminated strings.

I take that back... strndup not strdup.

However, the check on the length of the type is wrong with your patch (and in
the unpatched kernel). Can you pull in that bit from my patch?

David
