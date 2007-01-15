Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbXAOJSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbXAOJSZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbXAOJSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:18:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:9536 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbXAOJSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:18:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=DC0SEnQwXDpL3AWDxB9TDX2YWefS4dJHKUIm4OJYHfyajLOQRCZJWG4dFolypZmVSGQ0hCq4Rqd07RpzbPuKbk421zH/gPzqexXwYLwpkWFQAjwFMDZpgNxhHxpf50a93xL7/z5zK7J/CdFSP7issdl1o7QGryV912VRZuN3IMQ=
Date: Mon, 15 Jan 2007 11:17:28 +0200
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115091728.GF3874@Ahmed>
Mail-Followup-To: Greg KH <greg@kroah.com>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20070114172421.GA3874@Ahmed> <20070115002948.GB20993@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115002948.GB20993@kroah.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 04:29:48PM -0800, Greg KH wrote:
> On Sun, Jan 14, 2007 at 07:24:21PM +0200, Ahmed S. Darwish wrote:
> > Substitue intel_rng magic PCI IDs values used in the IDs table
> > with the macros defined in pci_ids.h
> 
> Why not use the PCI_DEVICE() macro too?  It should make the lines even
> smaller.

Ooh yes, I forgot about this macro.
Updating the patch. Thanks :).

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
