Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWGGJqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWGGJqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGGJqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:46:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932080AbWGGJqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:46:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706162731.577748e7.akpm@osdl.org> 
References: <20060706162731.577748e7.akpm@osdl.org>  <20060706105223.97b9a531.akpm@osdl.org> <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> <26133.1152211129@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 10:46:29 +0100
Message-ID: <20292.1152265589@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> binfmt_elf uses loff_t.

Hmmm...  It's not consistent about it though:

static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t offset)

David
