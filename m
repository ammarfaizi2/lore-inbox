Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUCPTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUCPT0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:26:52 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:24462 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261461AbUCPTZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:25:54 -0500
Date: Tue, 16 Mar 2004 19:21:01 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Romanick <idr@us.ibm.com>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: DRM reorganization
Message-ID: <20040316192101.GA17979@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Ian Romanick <idr@us.ibm.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <40562AEC.9080509@us.ibm.com> <20040315152621.43a5bcef.akpm@osdl.org> <40564723.4010105@us.ibm.com> <20040315163131.1b03b49f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315163131.1b03b49f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 04:31:31PM -0800, Andrew Morton wrote:

 > I've had a 130k DRM patch in -mm since February 8th.  Presumably it's out
 > of date.  As far as I know nobody is pushing more recent patches upstream.

The patch you've been carrying for a while has a number of bogons,
like duplicating pci.ids inside the radeon driver for no good reason.

 > What's the process here, and who should I be dealing with?

In the past most of the merges were done by Linus. I don't recall
seeing a 'dri maintainer' per se ever sending resync patches.

		Dave

