Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUDFP2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDFP2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:28:18 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23827 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263864AbUDFP2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:28:17 -0400
Date: Tue, 6 Apr 2004 17:28:16 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Workaround for ReiserFS on root-filesystem
Message-ID: <20040406152816.GC5953@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1HYFq-4mw-45@gated-at.bofh.it> <1HYYj-4Ap-5@gated-at.bofh.it> <4071BA3C.8080901@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071BA3C.8080901@tiscali.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 09:57:48PM +0200, Thomas Bach wrote:
> Daniel Andersen wrote:
> >>I use ReiserFS for my root-filesystem while trying to upgrade to a newer
> >>kernel-version (still using 2.4.20) I got a error, that / could not be
> >>remounted read/write. After googling a bit I stumbled over the fact that
> >>ReiserFS as root-filesystem doesn't work since version 2.4.22 (or
> >>something like this).
> 
> I tried all kinds of versions (2.4.22, 2.4.25, 2.6.2 and as allready 
> mentioned 2.6.5) non of them worked even after playing testing with all 
> kinds of options...

 It works for me here:

/dev/ide/host0/bus0/target0/lun0/part4 on / type reiserfs (rw,sync)

Linux mother 2.6.5 #10 Sun Apr 4 08:59:08 CEST 2004 i686 unknown unknown GNU/Linux

It always worked - with 2.4.x, 2.5.x, 2.6.x up to 2.6.5.
-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

