Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVLPT7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVLPT7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLPT7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:59:51 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:58632 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbVLPT7u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:59:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IoXFpOAxhVYl1wC4HFmEmRAAS6YxK+KvFR70CwHQGdsCf6q3w0zb/SXfl8SciuN+1Mj4N9A/fQcMDElIKdD8TIyoQYzo+MR+mQCUyy7mIHsPovaMJo9aIiW81erEC5dOBP5BVCQNGeb8Duesu66/eSQvhJyDjz38Hc2rOSVyBtU=
Message-ID: <eeb5c3c50512161159j1e41bd1u14f8cb025c4e79de@mail.gmail.com>
Date: Fri, 16 Dec 2005 20:59:49 +0100
From: Jim Meyering <jim@meyering.net>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 0/3] *at syscalls: Intro
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <43A2EA55.9070602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
	 <43A20B0B.5090205@pobox.com>
	 <eeb5c3c50512160332v3f026766w2c954f1482e84616@mail.gmail.com>
	 <43A2EA55.9070602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Ulrich Drepper <drepper@redhat.com> wrote:
> Jim Meyering wrote:
> > FYI, the rm in coreutils-cvs is finally thread-safe and race-free,
> > when using openat et al.
>
> Actually, Jim, I doubt it.

You seem to have misread.  I mentioned only `rm'.
I know full well that the other dir-traversing tools are not as robust.
