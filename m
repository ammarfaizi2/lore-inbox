Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVADO1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVADO1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVADO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:27:50 -0500
Received: from smtpout.mac.com ([17.250.248.85]:4573 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261730AbVADO1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:27:39 -0500
In-Reply-To: <200501041327.j04DRhfQ007850@laptop11.inf.utfsm.cl>
References: <200501041327.j04DRhfQ007850@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B470A11D-5E5C-11D9-A816-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Tue, 4 Jan 2005 15:27:04 +0100
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 14:27, Horst von Brand wrote:

> Felipe Alfaro Solana <lkml@mac.com> said:
>
> [...]
>
>> Gosh! I bought an ATI video card, I bought a VMware license, etc.... I
>> want to keep using them. Changing a "stable" kernel will continuously
>> annoy users and vendors.
>
> If you are sooo attached to this, just keep a distribution for which
> vendors give you drivers. But when the vendor decides the product has 
> to
> die to get you to buy the next "completely redone" (== minor fixes and
> updates) version, you are stranded for good.
>
>> I think new developments will force a 2.7 branch: when 2.6 feature set
>> stabilizes, people will keep more time testing a stable, relatively
>> static kernel base, finding bugs, instead of trying to keep up with
>> changes.
>
> And when 2.7 opens, very few developers will tend 2.6; and as 2.7 
> diverges
> from it, fewer and fewer fixes will find their way back. And so you 
> finally
> get a rock-stable (== unchanging) 2.6, but hopelessly out of date and 
> thus
> unfixable (if nothing else because there are no people around who 
> remember
> how it worked).

I can see no easy solution for this... If Linus decides to fork off 
2.7, development efforts will go into 2.7 and fixes should get 
backported to 2.6. If Linus decides to stay with 2.6, new development 
will have to be "conservative" enough not to break things that were 
working.

I tend to prefer forking off 2.7: more agressive features can be 
implemented and tested without bothering disrupting the stable 2.6 
branch.

