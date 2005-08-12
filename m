Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVHLRop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVHLRop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVHLRop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:44:45 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:11972 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750707AbVHLRop convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:44:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OfwnEhFqqjkfTTGFoHnpSXBsaz71ZIPQBNOe/4H1IHxXmgy5XwbT+mCp74gjiZsdKYDwL+2c/Tt/T962s326oJQveB4To1UXa/WI9GVC71cEZKibfFEzn7k54FRjscXuTIZQmpvsClEBxt7edYjixrqxHmO0BG9LGERx1Qzaof0=
Message-ID: <86802c4405081210442b1bb840@mail.gmail.com>
Date: Fri, 12 Aug 2005 10:44:44 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: APIC version and 8-bit APIC IDs
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050812164244.GC22901@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>
	 <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>
	 <20050812133248.GN8974@wotan.suse.de>
	 <42FCA97E.5010907@fujitsu-siemens.com>
	 <42FCB86C.5040509@fujitsu-siemens.com>
	 <20050812145725.GD922@wotan.suse.de>
	 <86802c44050812093774bf4816@mail.gmail.com>
	 <20050812164244.GC22901@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why matrin need to make apic id to be greater than 0x10 when system is
only 2way?

too much io-apic in system?

YH

On 8/12/05, Andi Kleen <ak@suse.de> wrote:
> On Fri, Aug 12, 2005 at 09:37:11AM -0700, yhlu wrote:
> > So MPTABLE do not have problem with it, only acpi related...?
> 
> It's only a cosmetic problem I think with the printk being
> wrong. The actual decision in the code should all use the true
> value.
> 
> Another way would be to just remove the printk output.
> 
> -Andi
>
