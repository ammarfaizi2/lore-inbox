Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266542AbUA3F7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUA3F7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:59:10 -0500
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:1945 "HELO
	boetes.org") by vger.kernel.org with SMTP id S266542AbUA3F7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:59:06 -0500
Date: Fri, 30 Jan 2004 07:00:06 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130060028.GB13535@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040128083645.GI2650@boetes.org> <20040130025142.GE3004@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130025142.GE3004@fs.tum.de>
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Jan 28, 2004 at 09:36:23AM +0100, Han Boetes wrote:
> > 
> > Hmmm my build breaks with:
> > 
> >   LD      .tmp_vmlinux1
> > arch/i386/kernel/built-in.o(.init.text+0x1342): In function `setup_memory':
> > : undefined reference to `find_smp_config'
> >...
> 
> You have a Voyager machine?
> You didn't enable SMP support?
> 
> Could you retry the compilation with SMP support enabled?

Andrew already replied to me in private. Seems like I accidentally 
selected the wrong processor-type during the make oldconfig. I hoped
nobody would notice ;)



# Han
