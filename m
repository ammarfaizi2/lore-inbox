Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWH2LBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWH2LBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWH2LBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:01:13 -0400
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:20152 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751030AbWH2LBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:01:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=YPO1gM9deY3kjOJKnvLZInA9mdcg+ipwY3/STMbHaDv/XQo3QfLQWQTgEygfZj8PInOgjSPPe0GpCj4W5NqECpls3JMRqh9nSjtYJyEabb2K9O5QOLw8Fbv4o1JOFhsCPagfymNHbK0ur8xpetw74Gf/DpCZ/gL9NDlDeghV+cQ=  ;
Date: Tue, 29 Aug 2006 13:01:10 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Jan Beulich <jbeulich@novell.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060829110109.GA10944@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20060820013121.GA18401@fieldses.org> <44E97353.76E4.0078.0@novell.com> <20060829085338.GA8225@gollum.tnic> <44F42BB1.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F42BB1.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 11:57:37AM +0200, Jan Beulich wrote:
> >>> Borislav Petkov <bbpetkov@yahoo.de> 29.08.06 10:53 >>>
> >Hi,
> >    I just read that unwinder thread and I think I have yet another case of
> >    unwinder backtrace that comes up together with the recursive deadlock
> >    protection backtrace and this happens with 18-rc5 so I thought I should
> >    report it before .18 is released:
> >...
> >Aug 29 10:21:22 zmei kernel: [  383.485261]  [<c0105393>] do_IRQ+0xc3/0xd0
> >Aug 29 10:21:22 zmei kernel: [  383.489393]  [<c0103521>] common_interrupt+0x25/0x2c
> >Aug 29 10:21:22 zmei kernel: [  383.494387] DWARF2 unwinder stuck at common_interrupt+0x25/0x2c
> >Aug 29 10:21:22 zmei kernel: [  383.500304] Leftover inexact backtrace:
> ></snip>
> 
> Unfortunately this leaves unclear whether there was anything reported in
> the leftover portion.
> And in all cases, a sufficiently long raw stack trace is needed to analyse this.
> Ideally a matching System.map would also be attached.
> 
> Jan

Actually, that's all there was in dmesg. System.map is at
http://tim.dnsalias.org/System.map-2.6.18-rc5.

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
