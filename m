Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTEAGOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTEAGOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:14:51 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:28945 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262416AbTEAGOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:14:50 -0400
Date: Thu, 1 May 2003 07:27:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, ricklind@us.ibm.com,
       solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501072703.A3705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>,
	viro@parcelfarce.linux.theplanet.co.uk, ricklind@us.ibm.com,
	solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
	frankeh@us.ibm.com
References: <20030430121105.454daee1.akpm@digeo.com> <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com> <20030430162108.09dbd019.akpm@digeo.com> <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk> <20030430165914.2facc464.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030430165914.2facc464.akpm@digeo.com>; from akpm@digeo.com on Wed, Apr 30, 2003 at 04:59:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:59:14PM -0700, Andrew Morton wrote:
> I think it's happening down inside the old linuxthreads library.  No idea
> who, what, where or why.

No, they're doing it themselves.  The RedHat OO package has a patch to
fix this mess (and two dozend other patches to work around OO braindamage..)

