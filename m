Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWJJObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJJObQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWJJObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:31:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:25246 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750820AbWJJObP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:31:15 -0400
Date: Tue, 10 Oct 2006 10:30:44 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061010143044.GA9645@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061004233137.97451b73.akpm@osdl.org> <m14pui4w7t.fsf@ebiederm.dsl.xmission.com> <20061005235909.75178c09.akpm@osdl.org> <m1bqop38nw.fsf@ebiederm.dsl.xmission.com> <20061006183846.GF19756@in.ibm.com> <4526A66B.4030805@zytor.com> <m1ac49z2fl.fsf@ebiederm.dsl.xmission.com> <4526D084.1030700@zytor.com> <20061009143345.GB17572@in.ibm.com> <20061009201418.81bf0acd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009201418.81bf0acd.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 08:14:18PM -0700, Andrew Morton wrote:
> On Mon, 9 Oct 2006 10:33:45 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > Please find attached the regenerated patch.
> 
> Somewhere amongst the six versions of this patch, the kernel broke.  Seems
> that the kernel command line isn't getting recognised.  The machine is
> running LILO and RH FC1.
> 
> I'll consolidate the patches which I have now and then I'll drop them.
> 

Hi Andrew,

I will find a machine having lilo and look into the issue. 

Instead of dropping all the patches, can't we just drop the last patch which
adds an elf header. Most likely this issue should be happening because of
that patch. Rest of the patches should be harmless.

Thanks
Vivek
