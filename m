Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBBXBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBBXBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVBBXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:00:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262794AbVBBXAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:00:20 -0500
Date: Wed, 2 Feb 2005 18:00:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens-dated-1107431785.31e3@endorphin.org>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <20050124115624.GA21457@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0502021756420.5090-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Fruhwirth Clemens wrote:

> This patch adds the ability for a cipher mode to store cipher mode specific
> information in crypto_tfm. This is necessary for LRW's precomputed
> GF-multiplication tables.

This one looks fine as part of the LRW patchset (i.e. not needed for 
generic scatterwalk).


- James
-- 
James Morris
<jmorris@redhat.com>



