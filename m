Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUHIUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUHIUeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUHIUc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:32:27 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:24587 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267185AbUHIUSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:18:15 -0400
Message-ID: <311601c90408091318699d0141@mail.gmail.com>
Date: Mon, 9 Aug 2004 14:18:10 -0600
From: Eric Mudama <edmudama@gmail.com>
To: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: Re: /dev/hdl not showing up because of fix-ide-probe-double-detection patch
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4117C028.7080905@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com>	 <20040804224709.3c9be248.akpm@osdl.org> <1091720165.8041.4.camel@localhost.localdomain> <4117C028.7080905@tupshin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 11:19:20 -0700, Tupshin Harper <tupshin@tupshin.com> wrote:
> I originally thought that the problem might be not enough bytes being
> checked, but now I'm concerned that Maxtor has some problem with not
> having a proper serial number recorded for some drives. hdparm -i also
> show M0000000000000000000 for both of these drives. Below is the output
> of hdparm -i for the two drives, and below that, the output of catting
> /dev/ide/hdk and hdl.
> 
> Doing a google search on "M0000000000000000000" shows that there have a
> been a handful of reports of maxtor drives showing this as the serial
> number, but I don't see any explanation of why.

The SN# is garbage in the ID block, I don't know why this is occurring
with our drives.  I am going to forward this note to our program lead
for that product to see if he's aware of the issue.  Unfortunately, if
the utility zone configuration is corrupt, I am not sure anything can
be done in the field to fix it... the drives might require an RMA. =/

--eric
