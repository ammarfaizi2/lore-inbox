Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVLFSpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVLFSpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVLFSpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:45:38 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:24591 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932619AbVLFSph convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:45:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ivypSXHKMseyCZybQ9J4MHzQxx+lxkMrALAWh7kYHN5vkhfCCTEuC/SZ9QRS10llKvdtzwujCeRPNNfstpPhia1PaGE9E+sPAYsdV5DsqwCoaK8Tp7n+Cwr5v1TcXMazsbCobXvSRNPdxWvLmiyFso/Esyw4DwPaFr9IsP5sq9Q=
Message-ID: <3aa654a40512061045h33fea2a0y1511366df2e7c166@mail.gmail.com>
Date: Tue, 6 Dec 2005 10:45:36 -0800
From: Avuton Olrich <avuton@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Kernel panic: Machine check exception
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <p73y82yqaaf.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132406652.5238.19.camel@localhost.localdomain>
	 <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	 <1132436886.19692.17.camel@localhost.localdomain>
	 <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
	 <p73y82yqaaf.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Dec 2005 12:45:44 -0700, Andi Kleen <ak@suse.de> wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> >
> > To decode an Opteron machine_check you can look in
> > the bios and kernel programmers guide.  (Possibly the

> mcelog --ascii decodes the "final" machine checks output
> by the 64bit kernel. The normal recoverable machine checks
> should be decoded at runtime assuming your distribution
> set it up right (normally into /var/log/mcelog)

That also works on kernel panic?

thanks,
avuton

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
