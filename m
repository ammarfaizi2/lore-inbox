Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292586AbSCDRhy>; Mon, 4 Mar 2002 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292599AbSCDRgg>; Mon, 4 Mar 2002 12:36:36 -0500
Received: from www.transvirtual.com ([206.14.214.140]:51214 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292592AbSCDRf7>; Mon, 4 Mar 2002 12:35:59 -0500
Date: Mon, 4 Mar 2002 09:35:47 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Raising an disabled tasklet / VC/KBD initialization bug.
In-Reply-To: <E16hwSl-0008PO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203040935260.20983-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > of disabled tasklets properly or make sure kbd_init and vc_init have defined
> > init order and the first always executes before the second. 
> > 
> > Comments? 
> 
> Oh this explains several non x86 reports. Yes We need to fix the link order

Better fix is to test the kam flag in struct vc_data. Will send patch.

