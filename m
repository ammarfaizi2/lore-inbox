Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUHQXrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUHQXrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUHQXrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:47:43 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16520 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268524AbUHQXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:47:40 -0400
Date: Wed, 18 Aug 2004 00:45:22 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040817234522.GA4170@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20040817220816.GA14343@hardeman.nu> <20040817233732.GA8264@redhat.com> <20040818004339.A27701@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040818004339.A27701@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 12:43:39AM +0100, Christoph Hellwig wrote:
 > On Wed, Aug 18, 2004 at 12:37:32AM +0100, Dave Jones wrote:
 > > On Wed, Aug 18, 2004 at 12:08:18AM +0200, David Härdeman wrote:
 > >  > [drm:i830_probe] *ERROR* Cannot initialize the agpgart module.
 > > 
 > > You don't have agpgart (and an agp chipset subdriver) loaded, yet
 > > drm 'needs' it.
 > 
 > Btw, any chance we can finally kill the inter_module_ bullshit in drm
 > and make it use normal depencies like every other driver on earth does?

The patch I saw from Rusty ripping out inter_module_* foo completely
did just that iirc.

		Dave

