Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUCEOdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUCEOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:33:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46235 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262607AbUCEOcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:32:02 -0500
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE9B4@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Mar 2004 07:23:38 -0700
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE9B4@fmsmsx406.fm.intel.com>
Message-ID: <m1smgnwexh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > 
> > Stupid question.  What is efi doing in arch/i386 anyway?
> 
> Not a stupid question at all. Despite the recent announcement, 
> efi is still working its way into x86 systems.  I think that 
> decision lies with OEMs.  I believe some are already out there...  
> 
> > All of the to be production efi x86 systems I have heard of support
> > x86-64.  So shouldn't it be 64bit calls that we need to worry about?
> 
> Not necessarily, although some systems (such as servers) will 
> indeed have support for x86-64.  I've just started looking at what 
> support needs to added for x86-64, in terms of efi, since I 
> learned about the announcement via cnet as well...  ;-(

Given how many pointers EFI exposes I don't see a way a
dual 32bit/64bit EFI could be made to work.  So either EFI needs
to go 64bit on x86, or it will start it's life with crippled.  Think
you could find this out?

If EFI is stuck at 32 bits on x86 it should be killed now.

Eric
