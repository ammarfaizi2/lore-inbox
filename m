Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCWKjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCWKjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCWKjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:39:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261360AbVCWKi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:38:57 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost> 
References: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost> 
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: security/keys/key.c broken with defconfig 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 10:38:53 +0000
Message-ID: <26892.1111574333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:

> If I just do a 'make defconfig' and then try to build security/keys/ the 
> build breaks.  Doing 'make allyesconfig' fixes it by defining CONFIG_KEYS 
> which makes include/linux/key-ui.h include the full struct key definition.

What arch? Please can you provide a copy of your .config file.

David
