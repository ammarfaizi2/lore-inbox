Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUG2PHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUG2PHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUG2PCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:02:55 -0400
Received: from jade.spiritone.com ([216.99.193.136]:11963 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S265053AbUG2OKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:10:11 -0400
Date: Thu, 29 Jul 2004 07:08:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
cc: alan@lxorguk.ukuu.org.uk, suparna@in.ibm.com, fastboot@osdl.org,
       jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <133880000.1091110104@[10.10.2.4]>
In-Reply-To: <20040728164457.732c2f1d.akpm@osdl.org>
References: <16734.1090513167@ocs3.ocs.com.au><20040725235705.57b804cc.akpm@osdl.org><m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com><200407280903.37860.jbarnes@engr.sgi.com><25870000.1091042619@flay><m14qnr7u7b.fsf@ebiederm.dsl.xmission.com><20040728133337.06eb0fca.akpm@osdl.org><1091044742.31698.3.camel@localhost.localdomain><m1llh367s4.fsf@ebiederm.dsl.xmission.com> <20040728164457.732c2f1d.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We really want to get into the new kernel ASAP and clean stuff up from
> in there.

As long as the "init" routines are run on every startup (not just kexec ones),
they should get plenty of testing (though not from bad card state).

I still think we could share code by running the shutdown routines from 
the *new* kernel  before trying to init the card if they're written in a 
robust way so as to allow it ... is that insane?

M.


