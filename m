Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbUKQDWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbUKQDWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKQDWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:22:08 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:37508 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262188AbUKQDVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:21:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PRrMyLn9m/iBE0bce0W87DwYGPqRjubgc+r52ckVlgKJ7U9dSQZPOApsxf3Lm6CY3mGWK8JVOJ+CYiSXx8PmzJVVX16J6MeE/wrc2BXHRSUwXThjOxEHJFBR+tj5uGmNLMVBarQb3Y5/z9KxK8rjMCUDJKticWE5KyNUJx32T/o=
Message-ID: <21d7e99704111619218577ffd@mail.gmail.com>
Date: Wed, 17 Nov 2004 14:21:24 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm1
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041116182233.097d9d85.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <1100640653.16765.0.camel@krustophenia.net>
	 <20041116182233.097d9d85.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry Andrew for the DUP- I'm still learning how to drive gmail :-)

> >  Why was the VIA DRM removed?  It was in 2.6.9-mm1 but seems to be gone
> >  now.
>

 I asked Andrew to kill it, I wasn't happy with it security wise still,
resurrecting it could be messy as the tree isn't converted over to the
core/library split, I'll probably pick it back up once Linus merges
the current diffs after 2.6.10 is released... VIA DRM still only is
useful for 2D HwMC stuff for non-root users, having to make a user run
3d apps as root is probably worse than having an in-secure DRM, so I'm
still waiting for the VIA/unichrome people to see what they can do
with it...

Dave.
