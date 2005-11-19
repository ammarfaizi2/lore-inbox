Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVKSKxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVKSKxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKSKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:53:06 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:53109 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751166AbVKSKxF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:53:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQu4V3Jm/fMROeSk7g/e1Euqffrd1gXqpkjNpGc5UbFblEwFUKUo/uDE5lTYi8SMlDyUGXDmIVK+TPuG7EXDkDeYdZeS1U7SEpuv/XQQYhAi/TnUfDFosu7AbdWhIO8F5a+r+55rFYts2FM3JSsRFq698pZSPHGYPBj4vWOuFgA=
Message-ID: <84144f020511190253p5f689346u8729bce45bd7df5@mail.gmail.com>
Date: Sat, 19 Nov 2005 12:53:03 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 7/12: eCryptfs] File operations
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <20051119042029.GG15747@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119042029.GG15747@sshock.rn.byu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +/**
> + * Opens the file specified by inode.
> + *
> + * @param inode        inode speciying file to open
> + * @param file Structure to return filled in
> + * @return Zero on success; non-zero otherwise
> + */

General comment: please use the kerneldoc format properly or don't use
kerneldoc at all.

                             Pekka
