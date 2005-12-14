Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVLNIhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVLNIhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLNIhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:37:42 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:52875 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbVLNIhl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:37:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dRHt+HdLQCO6qZTiCGXlrwobn5P6FA+t2b4PfrQmWNCKf8ud8JInPo94iOwHtRXYfYaz2YqJ9CIfD//ihMP3Jh8qVefqhoRfaL0b3zlnpzUudupUrGIb7sRYBwHhdI6JPFxSCSlU/ryhIjNtu9DoTN1/uh5TLHYghx9XBaUJlF0=
Message-ID: <84144f020512140037k5d687c66x35e3e29519764fb7@mail.gmail.com>
Date: Wed, 14 Dec 2005 10:37:39 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [RFC][PATCH 4/6] Slab Prep: slab_destruct()
Cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <439FD08E.3020401@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439FCECA.3060909@us.ibm.com> <439FD08E.3020401@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Matthew Dobson <colpatch@us.ibm.com> wrote:
> Create a helper function for slab_destroy() called slab_destruct().  Remove
> some ifdefs inside functions and generally make the slab destroying code
> more readable prior to slab support for the Critical Page Pool.

Looks good. How about calling it slab_destroy_objs instead?

                          Pekka
