Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVL1JgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVL1JgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVL1JgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:36:18 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:17271 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVL1JgS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:36:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0nMUiKDeEVpmMK00+ji0NydBX8BsXsE+XWsjqXlIWtyTX466cuJzVrO3Ljzfs2LiPElOkXm6aVg4lU4M0VkPTdbCUhtNB5IoEt3+afOgmWNdlu9LTxXuxvPMpIWle+cLNkmEJgqRWqq1T2m6eNcqlJtsL0WvEAJD2VdfM26DDE=
Message-ID: <ca992f110512280136s3fd3b31enca472108dc2232d1@mail.gmail.com>
Date: Wed, 28 Dec 2005 18:36:15 +0900
From: junjie cai <junjiec@gmail.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c900512280040g594ba003y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>
	 <2cd57c900512280040g594ba003y@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> > +static struct address_space_operations fat_mpage_aops = {
> > +       .readpage       = fat_mpage_readpage,
>
> Should use mpage_readpage directly?
>

no, it is used only when the cluster size is page-alignment

thanks.
                                              junjie
