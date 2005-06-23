Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVFWIIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVFWIIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVFWIEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:04:53 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:22307 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262500AbVFWG0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:26:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZsubFC+G7CDRoZmmI1ORvVWIYrmh3suAD/ULGEHOrIgCvGV1AyoteaRHBvIRiNHfT+1s9+5c215GelrKjVjc02JiUBEljsXFR/dCMedAZnFmKfgNBLhBj8+vy67Dc3R+8xBd6QmzypCRbMoUF+CnGk0fpM0pbVCctNlQL9ajMq4=
Message-ID: <84144f0205062223266ab40243@mail.gmail.com>
Date: Thu, 23 Jun 2005 09:26:37 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 plugins
Cc: Jeff Garzik <jgarzik@pobox.com>, David Masover <ninja@slaphack.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <42BA4F7E.6000402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>
	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
	 <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>
	 <42B8F4BC.5060100@pobox.com> <42BA4F7E.6000402@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Jeff Garzik wrote:
> > We have to maintain said ugly code for decades.

On 6/23/05, Hans Reiser <reiser@namesys.com> wrote:
> No you don't, I do.

Lots of people work on the kernel. If you wish to keep reiser4
maintenance to yourself, you probably need to keep it as a separate
patch. Please consider submitting the non-controversial bits for
merging first and then continue with the rest. It does not make a lot
of sense reviewing the current patchkit as many parts of it won't be
merged as is (e.g. the plugin stuff).

                          Pekka
