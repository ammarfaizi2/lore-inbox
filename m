Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUDGXNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUDGXNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:13:33 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5014 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261206AbUDGXNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:13:32 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Thu, 8 Apr 2004 09:13:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.35602.13336.290506@cse.unsw.edu.au>
Cc: Gewj <geweijin@sinosoft.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: A puzzling thing about RAID5: syslogd write the log success but another process can not read the /var/log/messages
In-Reply-To: message from Lars Marowsky-Bree on Wednesday April 7
References: <407400F1.8090809@sinosoft.com.cn>
	<20040407145126.GA23517@marowsky-bree.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 7, lmb@suse.de wrote:
> On 2004-04-07T21:24:01,
>    Gewj <geweijin@sinosoft.com.cn> said:
> 
> > hammm,tonight is funny because I got a puzzling thing just as....
> > 
> > my setup is a two-scsi-disk raid5 configuration...
> 
> Impossible. RAID5 requires at least three disks.

Wrong.  RAID5 works fine with just two drives.  Try it.

NeilBrown

(I admit that there isn't a lot of point doing raid5 with two drives
as raid1 should provide identical functionality with better
performance, but it makes an interesting base-line for performances
tests on N-drive arrays).

