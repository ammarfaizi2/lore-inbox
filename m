Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVGGXJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVGGXJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGGXJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 19:09:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:4318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262355AbVGGXGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 19:06:31 -0400
Date: Thu, 7 Jul 2005 16:06:09 -0700
From: Greg KH <greg@kroah.com>
To: serge@hallyn.com
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Tony Jones <tonyj@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050707230609.GA851@kroah.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050706220835.GA32005@serge.austin.ibm.com> <20050706222237.GB6696@kroah.com> <20050707173035.GA10503@vino.hallyn.com> <20050707174852.GA19609@kroah.com> <20050707182720.GA26431@serge.austin.ibm.com> <20050707224604.GA13117@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707224604.GA13117@vino.hallyn.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 05:46:04PM -0500, serge@hallyn.com wrote:
> 
> With the obvious fix, that does in fact work (patch appended).

Good.

> The __simple_attr_check_format problem remains however.  I assume we
> don't really want to just take it out, though, like this patch does?

No we do not.

> The error I get without the fs.h patch is:
> 
> security/seclvl.c: In function `seclvl_file_ops_open':
> security/seclvl.c:186: warning: int format, different type arg (arg 2)

Care to work to try to fix it up?

thanks,

greg k-h
