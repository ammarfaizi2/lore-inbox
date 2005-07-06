Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVGFXg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVGFXg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVGFXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:34:39 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:60630 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262466AbVGFXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:32:41 -0400
Date: Wed, 6 Jul 2005 18:32:19 -0500
From: serge@hallyn.com
To: Greg KH <greg@kroah.com>
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Tony Jones <tonyj@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706233219.GA16262@vino.hallyn.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050706220835.GA32005@serge.austin.ibm.com> <20050706222237.GB6696@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706222237.GB6696@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> > Or is there a better way to do this?
> 
> Look at how debugfs uses the libfs code.  We should not need to add
> these handlers to securityfs.

Ah, ok, thanks.  I think I've got it - will send out a new patch tomorrow.

thanks,
-serge
