Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754084AbWKRGuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbWKRGuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbWKRGuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:50:03 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27827 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754084AbWKRGuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:50:00 -0500
Date: Sat, 18 Nov 2006 07:49:49 +0100
From: Andi Kleen <ak@suse.de>
To: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz,
       vgoyal@in.ibm.com, Reloc Kernel List <fastboot@lists.osdl.org>,
       ebiederm@xmission.com, akpm@osdl.org, ak@suse.de, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 18/20] x86_64: Relocatable kernel support
Message-ID: <20061118064949.GH30547@bingen.suse.de>
References: <20061117223432.GA15449@in.ibm.com> <20061117225718.GS15449@in.ibm.com> <slrnelt84v.dd3.olecom@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnelt84v.dd3.olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 05:56:47AM +0000, Oleg Verych wrote:
> 
> On 2006-11-17, Vivek Goyal wrote:
> []
> >  static void error(char *x)
> > @@ -281,57 +335,8 @@ static void error(char *x)
> >  	while(1);	/* Halt */
> >  }
> 
> Is it possible to make this optional (using "panic" reboot timeout)?

There is no command line parsing at this point. I guess it would
be possible to implement, but some work. Do you want to submit a patch ?

-Andi
