Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUHQXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUHQXrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUHQXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:47:15 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:13574 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268526AbUHQXno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:43:44 -0400
Date: Wed, 18 Aug 2004 00:43:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>,
       =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040818004339.A27701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>,
	=?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20040817220816.GA14343@hardeman.nu> <20040817233732.GA8264@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040817233732.GA8264@redhat.com>; from davej@redhat.com on Wed, Aug 18, 2004 at 12:37:32AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 12:37:32AM +0100, Dave Jones wrote:
> On Wed, Aug 18, 2004 at 12:08:18AM +0200, David Härdeman wrote:
>  > [drm:i830_probe] *ERROR* Cannot initialize the agpgart module.
> 
> You don't have agpgart (and an agp chipset subdriver) loaded, yet
> drm 'needs' it.

Btw, any chance we can finally kill the inter_module_ bullshit in drm
and make it use normal depencies like every other driver on earth does?

