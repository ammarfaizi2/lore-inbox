Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCSBka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUCSBka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:40:30 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:51704 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262106AbUCSBkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:40:25 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Date: Thu, 18 Mar 2004 17:40:23 -0800
User-Agent: KMail/1.6.1
References: <1079651064.8149.158.camel@arrakis> <200403181711.05546.jbarnes@sgi.com> <Pine.LNX.4.58.0403182032130.28447@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403182032130.28447@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181740.23292.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 5:34 pm, Zwane Mwaikambo wrote:
> How about honouring DMA masks? Would this work with a 32bit DMA mask on a
> node with memory above the 4G mark. This is for the more impaired systems
> out there of course =)

Yeah, systems w/o an IOMMU are going to have trouble with this...

Jesse

