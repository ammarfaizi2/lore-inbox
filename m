Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbUK2WUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbUK2WUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUK2WTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:19:18 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:51635 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261834AbUK2WSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:18:52 -0500
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041128233934.GA2856@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296414.5805.286.camel@desktop.cunninghams>
	 <20041124132949.GB13145@infradead.org> <20041125192834.GB1302@elf.ucw.cz>
	 <1101680341.4343.291.camel@desktop.cunninghams>
	 <20041128233934.GA2856@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101766520.4343.418.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 30 Nov 2004 09:15:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-11-29 at 10:39, Pavel Machek wrote:
> Hi!
> 
> > > > > Here we add simple hooks so that the user can interact with suspend
> > > > > while it is running. (Hmm. The serial console condition could be
> > > > > simplified :>). The hooks allow you to do such things as:
> > 
> > > > > - change the amount of detail of debugging info shown
> > > 
> > > Use sysrq-X as you do during runtime.
> > 
> > No, I don't do this anymore. When I did, I had problems post-resume with
> > the keyboard handler sometimes thinking SysRq was still pressed.
> 
> Fix keyboard handler, then... It probably happens with other keys
> beside SysRq, right?

I guess it would. Nevertheless, it's ugly to have to press SysRq +
level; why make things more awkward than they need to be?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

