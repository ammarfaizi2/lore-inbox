Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVJEMRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVJEMRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVJEMRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:17:25 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:48258 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965143AbVJEMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:17:24 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.50271.962920.26612@gargle.gargle.HOWL>
Date: Wed, 5 Oct 2005 16:17:35 +0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051005111305.GS10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	<4342DC4D.8090908@perkel.com>
	<200510050122.39307.dhazelton@enter.net>
	<4343694F.5000709@perkel.com>
	<17219.39868.493728.141642@gargle.gargle.HOWL>
	<20051005095653.GK10538@lkcl.net>
	<17219.43860.610103.628963@gargle.gargle.HOWL>
	<20051005111305.GS10538@lkcl.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton writes:

[...]

 > > That's exactly the point: Unix file system model is more flexible than
 > > alternatives. 
 > 
 >  *grin*.  sorry - i have to disagree with you (but see below).
 > 
 >  i was called in to help a friend of mine at EDS to do a bastion sftp
 >  server to write some selinux policy files because POSIX filepermissions
 >  could not fulfil the requirements.

First, I was talking about flexibility attained through the separation
of notions of file and index. You just claimed elsewhere that this is
the direction ntfs took (with the introduction of hard-links).

Then, every security model has its weakness and corner cases. Try to
express

        rw-r-xrw- (0656)

POSIX bits with canonical NT ACLs (hint: in NT allow-ACEs are
accumulated).

[...]

 > 
 >  POSIX permissions were designed to fit into what... 16 bits,
 >  so they didn't have a lot to play with.

That very good property for a security model: simplicity is a virtue
here.

Nikita.
