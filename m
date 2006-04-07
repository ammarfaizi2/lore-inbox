Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWDGTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWDGTSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWDGTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:18:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40935 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964896AbWDGTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:18:12 -0400
Date: Fri, 7 Apr 2006 14:18:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: T??r??k Edwin <edwin@gurde.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       sds@tycho.nsa.gov
Subject: Re: [RFC][PATCH 7/7] stacking support for capability module
Message-ID: <20060407191804.GA28729@sergelap.austin.ibm.com>
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com> <200604072146.53572.edwin@gurde.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604072146.53572.edwin@gurde.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting T??r??k Edwin (edwin@gurde.com):
> Adds stacking support to capability module. Without this patch, I have to boot 
> with capability.disable=1 to get fireflier registered as security module.
> 
> What is current status of stacking support, how should LSM's handle stacking 
> with the capability module?

For now, pretty much like this.

The lsm stacker is still being kept up to date at
www.sf.net/projects/lsm-stacker.

-serge
