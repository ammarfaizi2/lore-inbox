Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVD1Gsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVD1Gsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVD1Gsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:48:36 -0400
Received: from smtp.istop.com ([66.11.167.126]:33442 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261673AbVD1Gsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:48:33 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Thu, 28 Apr 2005 02:49:04 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de>
In-Reply-To: <20050427134142.GZ4431@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280249.04735.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 09:41, Lars Marowsky-Bree wrote:
> If you want to think about this in terms of locking hierarchy, it's the
> high-level feature rich sophisticated aka bloated lock manager which
> controls the "lower level" faster and more scalable "sublockspace" and
> coordinates it in terms of the other complex objects (like fencing,
> applications, filesystems etc).
>
> Just some food for thought how this all fits together rather neatly.

It's actually the membership system that glues it all together.  The dlm is 
just another service.

Regards,

Daniel
