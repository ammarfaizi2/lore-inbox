Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270009AbUJUOPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbUJUOPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUJUOOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:14:23 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:53646 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270459AbUJUOMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:12:12 -0400
Subject: Re: [patch 2.6.9 0/11] Add MODULE_VERSION to several network
	drivers
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com,
       greearb@candelatech.com
In-Reply-To: <20041021085509.B29340@tuxdriver.com>
References: <20041020141146.C8775@tuxdriver.com>
	 <1098350269.2810.17.camel@laptop.fenrus.com>
	 <20041021082205.A29340@tuxdriver.com>
	 <1098366370.2810.31.camel@laptop.fenrus.com>
	 <20041021085509.B29340@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098367875.2810.36.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 16:11:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 14:55, John W. Linville wrote:
> > Not really. I have absolutely no problem with a MODULE_VERSION macro
> > *IF* the version it advertises means something. However if the version
> > it advertises has no meaning whatsoever (eg the version number never
> > gets updated) then imo it's better to NOT advertise anything so that
> > other tools (like dkms) don't make assumptions and decisions based on
> > nothing-meaning data.
> 
> Again, I think it would have to be the maintainer's responsibility
> to make the version numbers meaningful.

absolutely; however you're not the maintainer of all of the ones you
patched... and I still argue that until the number is meaningful
exporting it as meaning something is more harm than good.
