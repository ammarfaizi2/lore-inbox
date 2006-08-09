Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030668AbWHIKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030668AbWHIKgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbWHIKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:36:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7768 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030668AbWHIKgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:36:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CVuWs8i9jhx48oXbeEBz8bHLVbGoIHDbijkPphYbRqtcU0S65e/k6kfIQOADObVQVoxaD9gOk0Cbo97fbyjBPLsUUS8zi9c0Alx/+4/yD2Blfyl04yg9CdGuwX81bxLnEQLpO7LQGSgeN+yb5M5JfGtj9NHbtjCqzZOnSF6QV4A=
Message-ID: <62b0912f0608090336g574d957dk33bf554691518689@mail.gmail.com>
Date: Wed, 9 Aug 2006 12:36:13 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Cc: sergio@sergiomb.no-ip.org
In-Reply-To: <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> I have a ~1TB filesystem that fails to mount, the message is:
>
> EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
> group 2338 not in group (block 1607003381)!
> EXT3-fs: group descriptors corrupted !
>
> A day before, it worked flawlessly.
>
> What could have happened, and what's the best course of action?

I should probably mention that I've been bitten by e2fsck before.
I had a filesystem with minor damage, but after running e2fsck it was
completely nuked.
Nothing was recoverable.

So before anyone suggest running e2fsck, I'd really like someone
knowledgeable to tell me what e2fsck is going to do about "group
descriptors corrupted" *BEFORE* I go ahead and blindly run it.
