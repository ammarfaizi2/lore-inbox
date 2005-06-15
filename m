Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVFOWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVFOWEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVFOWE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:04:27 -0400
Received: from web31612.mail.mud.yahoo.com ([68.142.198.158]:27732 "HELO
	web31612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261602AbVFOWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:00:40 -0400
Message-ID: <20050615220032.67977.qmail@web31612.mail.mud.yahoo.com>
Date: Wed, 15 Jun 2005 15:00:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
To: serue@us.ibm.com, Chris Wright <chrisw@osdl.org>
Cc: Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       LSM <linux-security-module@wirex.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
In-Reply-To: <20050615215019.GB3660@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- serue@us.ibm.com wrote:

> Ok, so to be clear, any module which does not
> directly impose some form
> of access control is not eligible for an LSM?

In particular, an additional access control.
LSM is not for changing the existing policy,
it is for imposing additional policy.

You could, of course, add code to act on the
integrity measurements you've made, in which
case you could be in conformance with the
stated eligibilty requirements.

> (in that case that clearly settles the issue)

It sure took the wind out of the sails for the
SGI audit implementation.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
