Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUJUOLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUJUOLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUJUOFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:05:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:46097 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270723AbUJUOAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:00:08 -0400
Date: Thu, 21 Oct 2004 08:55:09 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com,
       greearb@candelatech.com
Subject: Re: [patch 2.6.9 0/11] Add MODULE_VERSION to several network drivers
Message-ID: <20041021085509.B29340@tuxdriver.com>
Mail-Followup-To: Arjan van de Ven <arjan@fenrus.demon.nl>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	davem@davemloft.net, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
	ctindel@users.sourceforge.net, fubar@us.ibm.com,
	greearb@candelatech.com
References: <20041020141146.C8775@tuxdriver.com> <1098350269.2810.17.camel@laptop.fenrus.com> <20041021082205.A29340@tuxdriver.com> <1098366370.2810.31.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098366370.2810.31.camel@laptop.fenrus.com>; from arjan@fenrus.demon.nl on Thu, Oct 21, 2004 at 03:46:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 03:46:11PM +0200, Arjan van de Ven wrote:
> On Thu, 2004-10-21 at 14:22, John W. Linville wrote:

> > I would have to suspect that if a version string exists, that it has at
> > least some meaning to the primary developers/maintainters.  It certainly
 
> Since the skeleton driver includes a define for that, I suspect your
> assumption is a bit overly optimistic. 
 
Perhaps...still, at least the drivers I touched w/ these patches seem to
have version numbers that are at least somewhat meaningful.

> > Is this a political statement against the MODULE_VERSION macro and/or
> > its purpose?  I'm not overly interested in debating that one...
> 
> Not really. I have absolutely no problem with a MODULE_VERSION macro
> *IF* the version it advertises means something. However if the version
> it advertises has no meaning whatsoever (eg the version number never
> gets updated) then imo it's better to NOT advertise anything so that
> other tools (like dkms) don't make assumptions and decisions based on
> nothing-meaning data.

Again, I think it would have to be the maintainer's responsibility
to make the version numbers meaningful.

John
-- 
John W. Linville
linville@tuxdriver.com
