Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVATDvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVATDvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVATDvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:51:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262035AbVATDvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:51:31 -0500
Date: Wed, 19 Jan 2005 22:51:24 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] agp_backend: remove drm_agp_t & inter_module_<foo> V1 [1/1]
Message-ID: <20050120035124.GA15621@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>
References: <20050120023832.GA3758@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120023832.GA3758@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 06:38:32PM -0800, Chris Wedgwood wrote:
 > What extremely obvious thing am I missing which prevents up from
 > kill drm_agp_t and the inter_module_register, etc. code that goes with
 > it?

Gar, this is the 3rd copy of this patch I've got.
I wanted the dust to settle on the agp carnage in -mm before
merging anything else, but tbh, I'm so sick of the sight
of this patch coming around every few days I'm going to merge
it and let Andrew deal with any resulting breakage when he
cuts the next -mm

		Dave

