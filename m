Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFWXt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFWXt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUFWXt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:49:29 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:32454 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262768AbUFWXtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:49:17 -0400
In-Reply-To: <Xine.LNX.4.44.0406221403100.28926-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0406221403100.28926-100000@thoron.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EF20BDC7-C56F-11D8-8D26-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com,
       Joy Latten <latten@austin.ibm.com>, kartik_me@hotmail.com,
       David Howells <dhowells@redhat.com>, arjanv@redhat.com
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RSA [patch #1]
Date: Wed, 23 Jun 2004 19:49:15 -0400
To: James Morris <jmorris@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 22, 2004, at 14:08, James Morris wrote:
> Different kernel asymmetric crypto apps (e.g. module signature checker)
> will need to be able to manage independent keyrings, and a common
> filesystem API would be useful for this.  e.g. during startup, some 
> init
> script loads keyrings into the kernel via 
> /proc/crypto/keyring/app/addkey

This is actually somewhat along the line that David Howells and I have
been working on; getting a key-ring system into the kernel.  We can
probably have a patch implementing the API we're working on in alpha
sometime in a couple weeks. This isn't really something that's useful to
the cryptoapi itself, but it could be used to debug new cryptoapi
functions.  In addition, cryptoapi will be very useful to the key-ring
system, if one is ever made.

Cheers,
Kyle Moffett


