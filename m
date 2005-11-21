Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVKUVls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVKUVls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVKUVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:41:47 -0500
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:22752 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751073AbVKUVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:41:46 -0500
Date: Mon, 21 Nov 2005 16:41:50 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Michael Halcrow <lkml@halcrow.us>
cc: Andrew Morton <akpm@osdl.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1
In-Reply-To: <20051121202825.GA17946@halcrow.us>
Message-ID: <Pine.LNX.4.63.0511211631140.479@excalibur.intercode>
References: <20051119041130.GA15559@sshock.rn.byu.edu> <20051118221659.64515ac0.akpm@osdl.org>
 <20051121202825.GA17946@halcrow.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Michael Halcrow wrote:

> I think you brought up two categories of potential security
> vulnerabilities.

> The first has to do with the theoretical security of
> the algorithms -- do the encrypted files really have the attribute
> such that decrypting the files without the proper key is
> computationally infeasible? This is the job for the cryptographers to
> confront.
> 
> The other category has to do with ``exploits''; I assume you are
> talking about -- for instance -- malicious files that are able to
> circumvent the intended behavior of the code. Such vulnerabilities may
> coerce the filesystem to dump the secret key out to an insecure
> location. This is an extension of the general ``correctness'' problem
> that can be an issue with any code. I would say that this is the job
> of the engineers to help prevent. It basically involves verification
> that eCryptfs is handling all of its memory correctly (i.e., via data
> and control flow analysis).

There's a third important category: the design of the _system_.

(Which you end up discussing somewhat further in the email).

It would be great to have a document which describes the design of the 
system and includes a comprehensive security analysis.


- James
-- 
James Morris
<jmorris@namei.org>
