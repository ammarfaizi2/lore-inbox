Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWILSFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWILSFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWILSFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:05:39 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:30350 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030322AbWILSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:05:37 -0400
Date: Tue, 12 Sep 2006 20:04:12 +0200
From: Mattia Dongili <malattia@linux.it>
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
Message-ID: <20060912180412.GA3947@inferi.kami.home>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609120008.19714.rjw@sisk.pl> <Pine.LNX.4.44L0.0609121007530.6338-100000@iolanthe.rowland.org> <20060912172211.GB6226@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912172211.GB6226@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 07:22:11PM +0200, Mattia Dongili wrote:
> On Tue, Sep 12, 2006 at 10:28:27AM -0400, Alan Stern wrote:
[...]
> > I was just going to send in a patch to fix the problem.  I haven't had
> > much of a chance to try it out yet.  The patch is included below, so you
> > can test it right away and let me know if it works for you before I submit 
> > it.
> 
> going to reboot to test it, hold on.

No luck here. I'll give -mm2 a run just to 

full dmesg
with patch applied[1]:
http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3-2

without it (it's almost identical :)):
http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3

.config:
http://oioio.altervista.org/linux/config-2.6.18-rc6-mm1-3

[1]: I didn't rebuild fully, just applied the patch and re-run make
bzImage modules

-- 
mattia
:wq!
