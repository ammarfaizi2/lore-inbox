Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULMOxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULMOxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULMOxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:53:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261228AbULMOxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:53:19 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20041211165451.GT22324@stusta.de> 
References: <20041211165451.GT22324@stusta.de> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] AFS: afs_voltypes isn't always required (fwd) 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Mon, 13 Dec 2004 14:52:10 +0000
Message-ID: <4659.1102949530@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk <bunk@stusta.de> wrote:

> afs_voltypes is only used #ifdef __KDEBUG, and even then it doesn't has 
> to be a global symbol.

I supposed I can always add this back with the next patch if I need it
then. It's currently used for a /proc file in my under-development code.

David
