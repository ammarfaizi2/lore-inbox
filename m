Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUGAAPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUGAAPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 20:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGAAPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 20:15:36 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:4508 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S263324AbUGAAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 20:15:35 -0400
Date: Wed, 30 Jun 2004 20:14:42 -0400
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-process namespace?
Message-ID: <20040701001442.GA28099@escher.cs.wm.edu>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com> <40E1DABD.9000202@sun.com> <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk> <40E2BCE1.3040302@sun.com> <1088619320.2927.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088619320.2927.77.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The per-process namespace concept comes in handy here except for the
> static nature of the namespace. In the sense, any changes to the system
> namespace do not reflect in the children namespace.

Static?

It's not static!  It's private, as advertised.

It sounds like you're asking (or your customer is asking) for
copy-on-write namespaces  :)
