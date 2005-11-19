Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVKSMGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVKSMGK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKSMGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:06:09 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:33717 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751090AbVKSMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:06:08 -0500
Date: Sat, 19 Nov 2005 13:05:48 +0100
From: Voluspa <lista1@telia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, kjarvel@home.se,
       howarth@bromo.msbb.uc.edu
Subject: Re: PCI error on x86_64 2.6.13 kernel
Message-Id: <20051119130548.1d86e1d9.lista1@telia.com>
In-Reply-To: <20051119011840.GB28175@kroah.com>
References: <20051118080440.4aaf4a6d.lista1@telia.com>
	<20051119011840.GB28175@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005 17:18:40 -0800 Greg KH wrote:
> Is there any way you could be able to run 'git bisect' between 2.6.12
> and 2.6.13 to try to find the offending changeset?  I would really
> appreciate it.

I'll take one beer (or in .ru: \u043f\u0438\u0432\u043e) for each hour ;-) This is a six-pack:

299de0343c7d18448a69c635378342e9214b14af is first bad commit
diff-tree 299de0343c7d18448a69c635378342e9214b14af (from 90b54929b626c80056262d9d99b3f48522e404d0)

Marvellous tool, that git. But it took less time - for us users - when we only had to
wave in a general -rc direction...

I've not tried to back the commit out from a 2.6.14 kernel, though. Will wait for a real fix.

Mvh
Mats Johannesson
--
