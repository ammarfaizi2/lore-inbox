Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266440AbUFQKJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266440AbUFQKJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUFQKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:09:07 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:48846 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266440AbUFQKJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:09:03 -0400
Date: Thu, 17 Jun 2004 11:08:14 +0100
From: Dave Jones <davej@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org,
       Ext3-users@redhat.com
Subject: Re: mode data=journal in ext3. Is it safe to use?
Message-ID: <20040617100813.GA19280@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hans Reiser <reiser@namesys.com>,
	Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org,
	Ext3-users@redhat.com
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com> <871xkfroph.fsf@enki.rimspace.net> <40D12DB6.3080606@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D12DB6.3080606@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 10:35:50PM -0700, Hans Reiser wrote:

 > >the reluctance of the developers to adapt to the 4K kernel stacks in
 > >2.6.recent,
 > >
 > do you use them?  I don't know real users who do, or else I would be 
 > quicker to care.

The Fedora Core 2 kernel (and what will be RHEL4) is currently
using 4K stacks.  This makes up quite a large userbase.

 > On the one hand, you complain about how we were unstable, and on the 
 > other hand you complain about how we aren't willing to destabilize the 
 > code to add new features to what is no longer the development branch.  
 > Seems pretty inconsistent logically to me.

If you really are reluctant it fix it, there's always the option of
marking CONFIG_REISER4 as dependant on CONFIG_BROKEN if CONFIG_4KSTACKS
is selected.

		Dave

