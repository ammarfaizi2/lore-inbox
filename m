Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUHGI7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUHGI7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 04:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUHGI7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 04:59:42 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:23938
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S261159AbUHGI7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 04:59:41 -0400
Subject: Re: [PATCH] implement in-kernel keys & keyring management
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
       jmorris@redhat.com, greg@kroah.com, Chris Wright <chrisw@osdl.org>,
       sfrench@samba.org, mike@halcrow.us, Kyle Moffett <mrmacman_g4@mac.com>
In-Reply-To: <6453.1091838705@redhat.com>
References: <6453.1091838705@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1091869155.4373.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 01:59:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 06/08/2004 klokka 17:31, skreiv David Howells:
>  - Two std keyrings per user: per-user and default-user-session

So what *is* the reason for the "per-user" and "default-user-session"
keys?

In a strong authentication model, a setuid process should not normally
find itself automatically authenticated to a new set of keys.

Cheers,
  Trond
