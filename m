Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVHESSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVHESSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVHESQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:16:04 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:4162 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262824AbVHESNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:13:33 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<52u0i6b9an.fsf_-_@cisco.com>
	<86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	<86802c4405080410236ba59619@mail.gmail.com>
	<86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	<86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	<86802c440508051103500f6942@mail.gmail.com>
	<86802c4405080511079d01532@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 05 Aug 2005 11:13:14 -0700
In-Reply-To: <86802c4405080511079d01532@mail.gmail.com> (yhlu's message of
 "Fri, 5 Aug 2005 11:07:27 -0700")
Message-ID: <52psss5k1x.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Aug 2005 18:13:25.0717 (UTC) FILETIME=[5F6A7850:01C599E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    yhlu> ps.  some kernel pci code patch broke sth yesterday night.
    yhlu> it mask out bit [32-39]

Is it possible that all your problems are coming from the PCI setup
code incorrectly assigning BARs?

 - R.
