Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWEQMCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWEQMCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWEQMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:02:07 -0400
Received: from web51406.mail.yahoo.com ([206.190.38.185]:51115 "HELO
	web51406.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750871AbWEQMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:02:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=w/mFx5gxMHr3lbkBUGTxRI65Tf9kzSoxZ+OZHp8KGltb7uAw2zzNO25HP8K8Flzp3eR6Mi2V/KbkdgVGZZ7Ckn1zxpTwWJCPqc9b59jtJmh+OK+vrfGlw7FyCqB2A1RjIOcpur4EGucH2qLZvNUb7+H4wI1B5kOyBvTOb+0q40E=  ;
Message-ID: <20060517120205.68976.qmail@web51406.mail.yahoo.com>
Date: Wed, 17 May 2006 14:02:05 +0200 (CEST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: Wiretapping Linux?
To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0605170618210.31079@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "linux-os (Dick Johnson)" wrote:
> 
> CPUs inside network cards (if any) don't run in the same address-space
> as your host CPU, memory, etc. Data is DMAed (set up on the host-CPU
> side) to/from this private bus, using the PCI bus. You would need
> very extensive cooperative code running on the host CPU (in the
> driver) to do anything useful. If you are going to write such
> driver code, you don't need the CPU inside the controller card
> at all because you are already running with high privileges on
> the correct bus.

Wiretapping is about listening in on communication. Network cards are the 
means this communication is carried out and see all the traffic somebody 
might want to tap into. This clearly makes it at least theoretically 
possible to use them as a listening device (and it sees all the other 
traffic on its network segment, too).

Additionally its listening on the system bus. Question: Can it tap into 
data addressed to another peripheral (say the hd controller)? If so, then 
only the system RAM is outside its scope.

Regards
  Joerg


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
