Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUBTVXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUBTVXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:23:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261333AbUBTVXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:23:51 -0500
Date: Fri, 20 Feb 2004 16:23:55 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@intercode.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <20040220190926.GB9980@certainkey.com>
Message-ID: <Xine.LNX.4.44.0402201622160.7335-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Jean-Luc Cooke wrote:

> > sense and would be redundant. CFB and CTR are not implemented
> > by cryptoloop BTW.
> 
> jlcooke:~/kern/linux-2.6.1/crypto$ grep CTR *.c
> cipher.c:       case CRYPTO_TFM_MODE_CTR:
> grep CFB *.c
> cipher.c:       case CRYPTO_TFM_MODE_CFB:
> 
> It should be I wrote it...the crypto part anyways.
> 

These are just placeholders.  Before this, we need to work out how to 
support stream ciphers in general (perhaps limit to 'byte' streams?).


- James
-- 
James Morris
<jmorris@redhat.com>


