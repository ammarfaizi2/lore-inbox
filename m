Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289639AbSA2MA5>; Tue, 29 Jan 2002 07:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSA2L7y>; Tue, 29 Jan 2002 06:59:54 -0500
Received: from [195.66.192.167] ([195.66.192.167]:49937 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289578AbSA2L6S>; Tue, 29 Jan 2002 06:58:18 -0500
Message-Id: <200201291156.g0TBudE28106@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rik van Riel <riel@conectiva.com.br>, John Weber <weber@nyc.rr.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 13:56:41 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201290902100.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201290902100.32617-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2002 09:04, Rik van Riel wrote:
> On Mon, 28 Jan 2002, John Weber wrote:
> > I would be happy to serve as patch penguin, as I plan on collecting all
> > patches anyway in my new duties as maintainer of www.linuxhq.com.
> >
> > we have the hardware/network capacity to serve as a limitless queue of
> > waiting patches for Linus.
>
> Please don't just accumulate stuff.

Right. Accepting any patch is wrong policy. You'll be swamped.
Patch must be marked "applies to 2.N.M", patch tracking system must check 
that automagically.

Also each patch(set) can be commented by general public and by maintainers.
If there is _no_ comment from any of _maintainers_ (i.e. it is not reviewed 
or found too ugly to worth commenting) it is automatically dropped from the 
system after some time.  This will force patch authors to care about code 
quality.

If patch is too old (several releases behind) system can mail author(s):
"Warning. Your patchset #3476346 needs rediffing. It will be dropped 
otherwise"

These "small" details determine whether system is useful or just turns into 
huge pile of patches of questionable value.
--
vda
