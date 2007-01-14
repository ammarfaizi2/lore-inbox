Return-Path: <linux-kernel-owner+w=401wt.eu-S1751271AbXANWdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbXANWdX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXANWdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:33:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:38998 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbXANWdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:33:22 -0500
From: Neil Brown <neilb@suse.de>
To: Fengguang Wu <fengguang.wu@gmail.com>
Date: Mon, 15 Jan 2007 09:32:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17834.44953.447617.272404@notabene.brown>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
In-Reply-To: message from Fengguang Wu on Saturday January 13
References: <17828.33075.145986.404400@notabene.brown>
	<368438638.13038@ustc.edu.cn>
	<20070110141756.GA5572@mail.ustc.edu.cn>
	<17829.46603.14554.981639@notabene.brown>
	<368527150.02925@ustc.edu.cn>
	<20070111145309.GA6226@mail.ustc.edu.cn>
	<17830.46175.410277.466742@notabene.brown>
	<368569131.07190@ustc.edu.cn>
	<20070112023251.GA6136@mail.ustc.edu.cn>
	<17831.58571.460279.128732@notabene.brown>
	<368654358.17532@ustc.edu.cn>
	<20070113021320.GA6055@mail.ustc.edu.cn>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday January 13, fengguang.wu@gmail.com wrote:
> On Sat, Jan 13, 2007 at 06:43:07AM +1100, Neil Brown wrote:
> > 
> > Ok, thanks.  I must have missed something else wrong in the code......
> > 
> > Probably this 'break' in the wrong place...
> > 
> > Could you try this patch instead please - or just move the 'break' to
> > where it should be.
> 
> Now it worked :)

Thanks.  I'll try to get those fixes into 2.6.20...

NeilBrown
