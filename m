Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWCJPzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWCJPzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWCJPzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:55:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751663AbWCJPz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:55:29 -0500
Date: Fri, 10 Mar 2006 10:55:17 -0500
From: Dave Jones <davej@redhat.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
       Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310155517.GB15214@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
	Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com> <20060310010050.GA9945@suse.de> <1141966693.14517.20.camel@camp4.serpentine.com> <1141977431.2876.18.camel@laptopd505.fenrus.org> <1141998702.28926.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141998702.28926.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 05:51:41AM -0800, Bryan O'Sullivan wrote:

 > What antique kernels?  It's not enabled in the latest SLES beta
 > (2.6.16-git6 or so), or in Fedora rawhide (also 2.6.16-git).

Bzzzrrt.

(10:54:01:davej@nemesis:~)$ uname -r
2.6.15-1.2027_FC5
(10:54:04:davej@nemesis:~)$ grep debug /proc/filesystems
nodev   debugfs

Been there since it was merged upstream.
It's not mounted anywhere by default, as imo, it shouldn't be.

		Dave

-- 
http://www.codemonkey.org.uk
