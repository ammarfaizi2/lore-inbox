Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVDMJiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDMJiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDMJiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:38:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8884 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261276AbVDMJiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:38:15 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi> 
References: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi> 
To: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix reproducible SMP crash in security/keys/key.c 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 13 Apr 2005 10:37:36 +0100
Message-ID: <11815.1113385056@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jani Jaakkola <jjaakkol@cs.Helsinki.FI> wrote:

> SMP race handling is broken in key_user_lookup() in security/keys/key.c
> (if CONFIG_KEYS is set to 'y').

A patch very much like the one you proposed is already resident in the latest
-rc kernels. Thanks anyway:-)

David
