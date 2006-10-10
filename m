Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWJJExZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWJJExZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWJJExZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 00:53:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50375 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964950AbWJJExY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 00:53:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
	<20061006183846.GF19756@in.ibm.com> <4526A66B.4030805@zytor.com>
	<m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
	<4526D084.1030700@zytor.com> <20061009143345.GB17572@in.ibm.com>
	<20061009201418.81bf0acd.akpm@osdl.org>
Date: Mon, 09 Oct 2006 22:51:19 -0600
In-Reply-To: <20061009201418.81bf0acd.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 9 Oct 2006 20:14:18 -0700")
Message-ID: <m1d590pyd4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Mon, 9 Oct 2006 10:33:45 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
>> Please find attached the regenerated patch.
>
> Somewhere amongst the six versions of this patch, the kernel broke.  Seems
> that the kernel command line isn't getting recognised.  The machine is
> running LILO and RH FC1.

Ugh.  That is no fun :(

Eric
