Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWBXHoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWBXHoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWBXHoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:44:25 -0500
Received: from lappc-f057.in2p3.fr ([134.158.97.63]:4483 "EHLO
	lappc-f057.in2p3.fr") by vger.kernel.org with ESMTP
	id S1750900AbWBXHoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:44:25 -0500
Subject: Re: isolcpus weirdness
From: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FEA182.2000904@yahoo.com.au>
References: <1140614487.13155.20.camel@localhost.localdomain>
	 <43FDA8DD.2000500@yahoo.com.au>
	 <1140700054.8314.44.camel@localhost.localdomain>
	 <43FDB910.1080402@yahoo.com.au>
	 <1140703394.8314.59.camel@localhost.localdomain>
	 <43FEA182.2000904@yahoo.com.au>
Content-Type: text/plain; charset=utf-8
Date: Fri, 24 Feb 2006 08:44:18 +0100
Message-Id: <1140767058.4925.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 24 février 2006 à 17:02 +1100, Nick Piggin a écrit :
> So I don't consider it a bug, but I'm looking at things from a
> very scheduler-centric point of view. Perhaps it wouldn't be
> unreasonable to exclude init from isolated CPUs at bootup... I
> wouldn't be against such a patch.

Ok. As you may have read in RTAI document, the point of cpu isolation in
a real time system is to make sure nothing apart real time tasks run on
isolated cpus. So if on a RTAI patched kernel I find the linux task
running on one of them, I guess it's a RTAI issue.

Thanks for your answers.

	Regards,

		Emmanuel.

