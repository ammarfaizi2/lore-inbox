Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVLFUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVLFUxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVLFUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:53:35 -0500
Received: from hera.kernel.org ([140.211.167.34]:19946 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030233AbVLFUxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:53:33 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Date: Tue, 6 Dec 2005 12:53:28 -0800
Organization: OSDL
Message-ID: <20051206125328.503a8871@localhost.localdomain>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
	<20051205195543.5a2e2a8d@griffin.suse.cz>
	<4394902C.8060100@pobox.com>
	<20051205195329.GB19964@redhat.com>
	<20051206151046.GF4038@rama.exocore.com>
	<4395E0E3.4040601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1133902409 7987 10.8.0.222 (6 Dec 2005 20:53:29 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 6 Dec 2005 20:53:29 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2005 14:05:07 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Harald Welte wrote:
> > I also think that there is a lack of knowledge on the architecture of
> > 802.11 low-level protocols and drivers among many people (including
> > myself) in the network community.  Only this way I can explain why there
> > are always people who claim that the kernel already has a 802.11
> > 'stack'.
> 
> This last sentence, regardless of the source, is simply playing with words.
> 
> We have 802.11 common code in the kernel, that several drivers are 
> using.  Future drivers should modify that common code to suit their 
> needs, rather than dropping it and starting from scratch.

Also, the correct way to built network code is often not aligned with
the artificial layering imposed by standards. 

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
