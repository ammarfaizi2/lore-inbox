Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUFSWYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUFSWYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFSWYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:24:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262381AbUFSWYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:24:16 -0400
Date: Sat, 19 Jun 2004 19:17:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>, Andrew Morton <akpm@osdl.org>,
       sdake@mvista.com, liste@jordet.nu, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-ID: <20040619221711.GA2287@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com> <20040617131600.GB3029@logos.cnet> <20040617200859.7fada9fe.akpm@osdl.org> <20040619194849.GA2843@logos.cnet> <20040619195013.GA6672@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619195013.GA6672@janus>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 09:50:13PM +0200, Frank van Maarseveen wrote:
> On Sat, Jun 19, 2004 at 04:48:49PM -0300, Marcelo Tosatti wrote:
> > 
> > However, he also mentioned that his crashes started after upgrading 
> > from v2.4.19->2.4.22. Should search the diff between them looking for 
> > anything suspicious.
> > 
> > I can't figure out from the archived reports if this is UP or SMP only. 
> > 
> > Frank van Maarseveen has also seen the journal_try_to_free_buffers() NULL 
> > b_this_page. Frank, were you running SMP or UP when you reported the oops 
> > with 2.4.23? 
> 
> UP

Hi Frank,

Has the oops happened again? What kernel are you running now?

Thanks!
