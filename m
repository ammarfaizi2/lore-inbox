Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUKIJlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUKIJlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKIJlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:41:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55442 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261460AbUKIJfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:35:40 -0500
Date: Tue, 9 Nov 2004 11:37:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olivier Poitrey <olivier@pas-tres.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, diffie@blazebox.homeip.net,
       Greg KH <greg@kroah.com>, diffie@gmail.com
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109103733.GA15065@elte.hu>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org> <792238A4-3224-11D9-9F1E-000D934362B4@pas-tres.net> <1099988562.3989.4.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099988562.3989.4.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2004-11-09 at 08:53 +0100, Olivier Poitrey wrote:
> > On 9 nov. 04, at 06:27, Andrew Morton wrote:
> > 
> > > [...] Is there a requirement to support more than 256 legacy ptys?
> > 
> > Yes it is. For big vserver hosting systems for instance, running like
> > 100 vservers per node you can easily hit this limit.
> 
> but do you really need the legacy pty's for that instead of the
> "modern" ones ?

probably not, but if the fix is easy then there's no reason not to do
it.

	Ingo
