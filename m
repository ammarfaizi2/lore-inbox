Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCCA5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCCA5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCCAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:54:58 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:49336 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261340AbVCCAwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:52:20 -0500
Date: Wed, 2 Mar 2005 19:52:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Something is broken with SATA RAID ?
Message-ID: <20050303005210.GA1140@havoc.gtf.org>
References: <1109810381l.5754l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109810381l.5754l.0l@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:39:41AM +0000, J.A. Magallon wrote:
> Hi...
> 
> I posted this in other mail, but now I can confirm this.
> 
> I have a box with a SATA RAID-5, and with 2.6.11-rc3-mm2+libata-dev1
> works like a charm as a samba server, I dropped it 12Gb from an
> osx client, and people does backups from W2k boxes and everything was fine.
> With 2.6.11-rc4-mm1, it hangs shortly after the mac starts copying
> files. No oops, no messages... It even hanged on a local copy (wget),
> so I will discard samba as the buggy piece in the puzzle.
> 
> I'm going to make a definitive test with rc5-mm1 vs rc5-mm1+libata-dev1.
> I already know that plain rc5-mm1 hangs. I have to wait the md reconstruction
> of the 1.2 TB to check rc5-mm1+libata (and no user putting things there...)

Please eliminate -mm and -libata-dev from the equation.

	Jeff



