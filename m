Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVLNITg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVLNITg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVLNITg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:19:36 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:20325 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932103AbVLNITf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:19:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hsz+MABusyL7C97ppV4CMVh2TDjpH6ziPDU0NzKFnI8Wfnuso0wBA9Wm0BlCCkFdSM8uXl6aMtgzbRnA4C3ovsbri5HnG5oYY+5HsWT1qyO54dBfJikvv9CWp1b2LvhJJ0JBiszMeLr5b0RckB8QGdz1WwFfSz64Dijv+tZOsUo=
Message-ID: <84144f020512140019h1390c9eayf8b4b0dd03d8be1c@mail.gmail.com>
Date: Wed, 14 Dec 2005 10:19:33 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [RFC][PATCH 3/6] Slab Prep: get/return_object
Cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <439FD031.1040608@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439FCECA.3060909@us.ibm.com> <439FD031.1040608@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 12/14/05, Matthew Dobson <colpatch@us.ibm.com> wrote:
> Create 2 helper functions in mm/slab.c: get_object() and return_object().
> These functions reduce some existing duplicated code in the slab allocator
> and will be used when adding Critical Page Pool support to the slab allocator.

May I suggest different naming, slab_get_obj and slab_put_obj ?

                                            Pekka
