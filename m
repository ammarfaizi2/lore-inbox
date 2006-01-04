Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWADV2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWADV2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWADV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:28:36 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:56462 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751804AbWADV2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:28:35 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 0 of 20] [RFC] ipath - PathScale
 InfiniPath driver
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1135816279@eng-12.pathscale.com>
	<20051230080002.GA7438@kroah.com>
	<1135984304.13318.50.camel@serpentine.pathscale.com>
	<20051231001051.GB20314@kroah.com>
	<1135993250.13318.94.camel@serpentine.pathscale.com>
	<20060103172732.GA9170@kroah.com>
	<1136321691.10862.61.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 04 Jan 2006 13:28:29 -0800
In-Reply-To: <1136321691.10862.61.camel@localhost.localdomain> (Bryan
 O'Sullivan's message of "Tue, 03 Jan 2006 12:54:50 -0800")
Message-ID: <adasls34r9e.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 04 Jan 2006 21:28:29.0551 (UTC) FILETIME=[CE3BCFF0:01C61175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> It does when our OpenIB driver is being used.  But our
    Bryan> lower level driver is independent of OpenIB (and is often
    Bryan> used without the infiniband stuff even configured into the
    Bryan> kernel), and needs to provide some way for a userspace
    Bryan> subnet management agent to send and receive packets.

Isn't there some way you can use the same SMA (subnet management
agent) interface in all the cases?  Can ipath_mad.c just go away in
favor of your userspace SMA?

 - R.
