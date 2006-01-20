Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWATLdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWATLdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWATLdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:33:06 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:983 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750845AbWATLdE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:33:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kZeZX/2QS3aZbxGF3ZRoU1BlejeqcwOF0Il0ITx4C4qG48K86ztGi6uA6FKeFM0bt1eMDfF1j+sQHjhFSZs1IfU40vqCMVbOwE9c0cbaWrNEMBV0WKETeUJoOdzO1lFVyZatOjvggUWuOr9Si0ET0hkn46zIZ5HM2c19lo4Cl4U=
Message-ID: <84144f020601200333y2d2c994av96d855e300411006@mail.gmail.com>
Date: Fri, 20 Jan 2006 13:33:03 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120031555.7b6d65b7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 1/20/06, Andrew Morton <akpm@osdl.org> wrote:
+produce-useful-info-for-kzalloc-with-debug_slab.patch
>
>  Make kzalloc() play properly with slab debugging

Hmm. This still leaves kstrdup() broken which is why I would prefer
the following patch to be applied:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113767657400334&w=2

                                            Pekka
