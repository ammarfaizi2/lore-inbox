Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUATRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUATRqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:46:09 -0500
Received: from ns.suse.de ([195.135.220.2]:22677 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265592AbUATRqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:46:06 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org.suse.lists.linux.kernel>
	<20040118001217.GE3125@werewolf.able.es.suse.lists.linux.kernel>
	<20040117215535.0e4674b8.akpm@osdl.org.suse.lists.linux.kernel>
	<20040118081128.GA3153@werewolf.able.es.suse.lists.linux.kernel>
	<20040118001708.09291455.akpm@osdl.org.suse.lists.linux.kernel>
	<20040119224219.65991501.rusty@rustcorp.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Jan 2004 13:40:56 +0100
In-Reply-To: <20040119224219.65991501.rusty@rustcorp.com.au.suse.lists.linux.kernel>
Message-ID: <p73r7xwglgn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Migrating to module_param() is the Right Thing here IMHO, which actually
> takes the damn address,

The main problem is that module_parm renames the boot time arguments and
makes them long and hard to remember. E.g. the new argument needed to
make the mouse work on KVMs is mindboogling, could be nearly a Windows
registry entry.

-Andi
