Return-Path: <linux-kernel-owner+w=401wt.eu-S1760795AbWLHSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760795AbWLHSK6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760797AbWLHSK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:10:58 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:36497 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760795AbWLHSK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:10:57 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Andi Kleen <ak@suse.de>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 19:10:39 +0100
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <200612081403.13404.arekm@maven.pl> <200612081904.33205.ak@suse.de>
In-Reply-To: <200612081904.33205.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612081910.39684.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 19:04, Andi Kleen wrote:
> > > > Something related (git tree fetched 1-2h ago) ?
> > >
> > > Probably. Please send your .config.
> >
> > #
> > # Automatically generated make config: don't edit
> > # Linux kernel version: 2.6.19
> > # Fri Dec  8 11:40:15 2006
> > #
> > CONFIG_X86_32=y
>
> I built your config and it builds fine here with gcc 4.1/binutils
> 2.17.50.0.5
>
> What compiler version do you have?

binutils-2.17.50.0.8-1.i686
gcc-4.2.0-0.20061206r119598.2.i686

> _proxy_pda shouldn't be referenced at all -- it just a dummy to tell
> the compiler about the side effects of the PDA operations.
>
> -Andi

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
