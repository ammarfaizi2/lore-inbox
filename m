Return-Path: <linux-kernel-owner+w=401wt.eu-S1751572AbXALCc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXALCc2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbXALCc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:32:28 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:45090 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751569AbXALCc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:32:27 -0500
Message-ID: <368569131.07190@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 12 Jan 2007 10:32:51 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070112023251.GA6136@mail.ustc.edu.cn>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <367964923.02447@ustc.edu.cn> <20070105024226.GA6076@mail.ustc.edu.cn> <17828.33075.145986.404400@notabene.brown> <368438638.13038@ustc.edu.cn> <20070110141756.GA5572@mail.ustc.edu.cn> <17829.46603.14554.981639@notabene.brown> <368527150.02925@ustc.edu.cn> <20070111145309.GA6226@mail.ustc.edu.cn> <17830.46175.410277.466742@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17830.46175.410277.466742@notabene.brown>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:04:15AM +1100, Neil Brown wrote:
> On Thursday January 11, fengguang.wu@gmail.com wrote:
> > Neil,
> > 
> > On Thu, Jan 11, 2007 at 02:59:07PM +1100, Neil Brown wrote:
> > > On Wednesday January 10, fengguang.wu@gmail.com wrote:
> > > > 
> > > > root ~# mount localhost:/suse /mnt
> > > > [  132.678204] svc: unknown version (3 for prog 100227, nfsd)
> > > > 
> > > > I've confirmed that 2.6.20-rc2-mm1, 2.6.20-rc3-mm1, 2.6.19-rc6-mm1 all
> > > > have this warning, while 2.6.17-2-amd64 is good.
> > > 
> > > Thanks.  That helps a lot.
> > > 
> > > This patch should help too.  Please let me know.
> > 
> > # mount localhost:/suse /mnt
> > [ 2058.438236] svc: unknown version (3 for prog 100227, nfsd)
> 
> Are you really really double-plus sure that you are running a kernel
> with the patch applied?
> Because at the very least it should have changed the message to

Oh, sorry. I recompiled & installed kernel and it output this new message:

[  133.129919] svc: unknown version (3 for prog 100227, nfsacl)

Regards,
Wu
