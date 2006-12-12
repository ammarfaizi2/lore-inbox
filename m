Return-Path: <linux-kernel-owner+w=401wt.eu-S1751431AbWLLPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWLLPhg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWLLPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:37:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48521 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbWLLPhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:37:35 -0500
Subject: Re: Support 2.4 modules features in 2.6
From: Arjan van de Ven <arjan@infradead.org>
To: Jaswinder Singh <jaswinderrajput@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aa5953d60612120711h375eecadpeb20d971853626cc@mail.gmail.com>
References: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
	 <1165932674.27217.608.camel@laptopd505.fenrus.org>
	 <aa5953d60612120711h375eecadpeb20d971853626cc@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 12 Dec 2006 16:37:33 +0100
Message-Id: <1165937853.27217.625.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 20:41 +0530, Jaswinder Singh wrote:
> On 12/12/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Tue, 2006-12-12 at 19:36 +0530, Jaswinder Singh wrote:
> > > Hello,
> > >
> > > I want to support old 2.4 modules features in 2.6 kernel modules:-
> > > 1. no kernel source tree is required to build modules.
> >
> > this is a 2.6 not a 2.4 feature btw
> >
> 
> Really!! , Please let me know what is the procedure to build the
> modules after deleting kernel linux-2.6*

you only need include/* for this in 2.6

you can't do this at all with 2.4 kernels, it needs the whole lot.

(in both cases the code and headers are needed so that your module can
use the data structures and compile in the kernel code you select to use
from inlines)
> 
> 
> > > 2. support modular plugins.
> >
> > ?
> 
> modular plugins means :-

you can still do that. Just you're better off building them in one go;


can you give us a pointer to the source of this 2.4 module you have?
Maybe some of the mechanisms that you want this for are now very
outdated and obsoleted by easier functionality.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

