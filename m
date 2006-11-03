Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753120AbWKCNrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbWKCNrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbWKCNrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:47:47 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:55221 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1753120AbWKCNrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:47:46 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17739.18555.30814.617461@gargle.gargle.HOWL>
Date: Fri, 3 Nov 2006 16:47:39 +0300
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.64.0611030235050.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	<p73velxju18.fsf@verdi.suse.de>
	<Pine.LNX.4.64.0611030235050.7781@artax.karlin.mff.cuni.cz>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000450 cbc06b918a8f8d56d17fa8331d4338a3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:
 > > Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:
 > >
 > >> new method to keep data consistent in case of crashes (instead
 > >> of journaling),
 > >
 > > What is that method?
 > 
 > Some tricks to avoid journal --- see 
 > http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/download/INTERNALS
 > 
 > --- unlike journaling it survives only 65536 crashes :)

What happens when hard-linked file is accessed, and it is found that
last fnode (one in fixed_fnode_block), has wrong "crash count"?

Nikita.

