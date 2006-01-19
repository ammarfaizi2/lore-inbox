Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWASBRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWASBRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWASBRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:17:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:11403 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161143AbWASBRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:17:24 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060119005316.GA26884@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060119005316.GA26884@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 17:17:20 -0800
Message-Id: <1137633441.4757.228.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 16:53 -0800, Greg KH wrote:

> Use the firmware subsystem for this.  It uses sysfs so ioctl needed at
> all.

OK.  Would I be correct in thinking that drivers/firmware/dcdbas.c is a
reasonable model implementation to follow?

	<b

