Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVDEXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVDEXtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVDEXsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:48:04 -0400
Received: from mail.autoweb.net ([198.172.237.26]:19661 "EHLO mail")
	by vger.kernel.org with ESMTP id S262006AbVDEXqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:46:45 -0400
Date: Tue, 5 Apr 2005 19:46:02 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Greg KH <gregkh@suse.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, stable@kernel.org,
       amy.griffis@hp.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: [03/08] fix ia64 syscall auditing
Message-ID: <20050405234602.GC4800@mythryan2.michonline.com>
References: <20050405164539.GA17299@kroah.com> <20050405164647.GD17299@kroah.com> <16978.62622.80542.462568@napali.hpl.hp.com> <1112734158.468.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112734158.468.0.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 01:49:18PM -0700, Greg KH wrote:
> On Tue, 2005-04-05 at 13:27 -0700, David Mosberger wrote:
> > >>>>> On Tue, 5 Apr 2005 09:46:48 -0700, Greg KH <gregkh@suse.de> said:
> > 
> >   Greg> -stable review patch.  If anyone has any objections, please
> >   Greg> let us know.
> > 
> > Nitpick: the patch introduces trailing whitespace.
> 
> Sorry about that, I've removed it from the patch now.
> 
> > Why doesn't everybody use emacs and enable show-trailing-whitespace? ;-)
> 
> Because some of us use vim and ":set list" to see it, when we remember
> to... :)

Try adding this to your .vimrc:

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

Then you'll have to resist the urge to fix whitespace issues instead of
not seeing them at all.

-- 

Ryan Anderson
  sometimes Pug Majere
