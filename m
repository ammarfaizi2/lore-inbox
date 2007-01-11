Return-Path: <linux-kernel-owner+w=401wt.eu-S932103AbXAKWEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXAKWEj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbXAKWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:04:39 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44016 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbXAKWEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:04:38 -0500
From: Neil Brown <neilb@suse.de>
To: Fengguang Wu <fengguang.wu@gmail.com>
Date: Fri, 12 Jan 2007 09:04:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17830.46175.410277.466742@notabene.brown>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
In-Reply-To: message from Fengguang Wu on Thursday January 11
References: <367964923.02447@ustc.edu.cn>
	<20070105024226.GA6076@mail.ustc.edu.cn>
	<17828.33075.145986.404400@notabene.brown>
	<368438638.13038@ustc.edu.cn>
	<20070110141756.GA5572@mail.ustc.edu.cn>
	<17829.46603.14554.981639@notabene.brown>
	<368527150.02925@ustc.edu.cn>
	<20070111145309.GA6226@mail.ustc.edu.cn>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 11, fengguang.wu@gmail.com wrote:
> Neil,
> 
> On Thu, Jan 11, 2007 at 02:59:07PM +1100, Neil Brown wrote:
> > On Wednesday January 10, fengguang.wu@gmail.com wrote:
> > > 
> > > root ~# mount localhost:/suse /mnt
> > > [  132.678204] svc: unknown version (3 for prog 100227, nfsd)
> > > 
> > > I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
> > > have this warning, while 2.6.17-2-amd64 is good.
> > 
> > Thanks.  That helps a lot.
> > 
> > This patch should help too.  Please let me know.
> 
> # mount localhost:/suse /mnt
> [ 2058.438236] svc: unknown version (3 for prog 100227, nfsd)

Are you really really double-plus sure that you are running a kernel
with the patch applied?
Because at the very least it should have changed the message to

> [ 2058.438236] svc: unknown version (3 for prog 100227, nfsacl)

NeilBrown
