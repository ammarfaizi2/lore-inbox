Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314900AbSDVXDq>; Mon, 22 Apr 2002 19:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314904AbSDVXDp>; Mon, 22 Apr 2002 19:03:45 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:6162 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314900AbSDVXDo>;
	Mon, 22 Apr 2002 19:03:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available 
In-Reply-To: Your message of "Mon, 22 Apr 2002 16:36:06 +0200."
             <20020422163606.A1142@riesen-pc.gr05.synopsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 09:03:34 +1000
Message-ID: <5928.1019516614@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 16:36:06 +0200, 
Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>On Sun, Apr 21, 2002 at 05:43:08PM +1000, Keith Owens wrote:
>> 
>> Release 2.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
>> release 2.1.
>> 
>
>Hi, i've got some problems with 2.1:
>.../v2.5-1/arch/i386/kernel/entry.S:223: unterminated character constant
>.../v2.5-1/arch/i386/kernel/entry.S:264: unterminated character constant
>.../v2.5-1/arch/i386/kernel/entry.S:280: unterminated character constant
>That was Linus's bk tree (cset 1.562)
>+ kbuild-2.5-core-4
>+ kbuild-2.5-common-2.5.8-pre3-1
>+ kbuild-2.5-i386-2.5.8-pre3-1

Those are not release 2.1 files, you are using old patches.  Release
2.1 uses core-6 and patches for 2.5.8, not 2.5.8-pre3.

>P.S. "phase 1" for xconfig is evil, is it absolutely unavoidable?

Yes.  A driver may not be in the main kernel source tree, it can be in
a separate tree.  Phase 1 finds all the files in all trees, including
config files.

