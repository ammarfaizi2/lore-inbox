Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUK1Wi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUK1Wi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUK1Wi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:38:29 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28342 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261295AbUK1WiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:38:25 -0500
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125192834.GB1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296414.5805.286.camel@desktop.cunninghams>
	 <20041124132949.GB13145@infradead.org>  <20041125192834.GB1302@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101680341.4343.291.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 09:34:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 06:28, Pavel Machek wrote:
> > > Here we add simple hooks so that the user can interact with suspend
> > > while it is running. (Hmm. The serial console condition could be
> > > simplified :>). The hooks allow you to do such things as:

> > > - change the amount of detail of debugging info shown
> 
> Use sysrq-X as you do during runtime.

No, I don't do this anymore. When I did, I had problems post-resume with
the keyboard handler sometimes thinking SysRq was still pressed.
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

