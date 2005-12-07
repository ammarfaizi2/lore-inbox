Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVLGPBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVLGPBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVLGPBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:01:40 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:20413 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751119AbVLGPBj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:01:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qY8oFXKhvKFOswiloTChIuTVzBezELnrMi3nYsxBUxIuRotUkbFCkwySRBKZCIORMGckwH/+xQWruj1WBZaPBDhkc+d9R8zOHdToYNvJtuigx7UW2ddxx6PUqfBTzEQN8e6XhSHwA5RdmekEtUsx29OmZUJrMqXrwvOLADNMmCw=
Message-ID: <84144f020512070701s344f721dsd92f33d5f275a453@mail.gmail.com>
Date: Wed, 7 Dec 2005 17:01:37 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Marco Correia <mvc@di.fct.unl.pt>
Subject: Re: slow boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512071027.26364.mvc@di.fct.unl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512071027.26364.mvc@di.fct.unl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 12/7/05, Marco Correia <mvc@di.fct.unl.pt> wrote:
> I've been experiencing very VERY slow boots after I've upgraded from kernel
> 2.6.10 to 2.6.14.2. The boot process is fast until the start of the init
> script, after this 2.6.14.2 spends 10 seconds or so for each init task.

It would be helpful if you could identify the exact version where this
regression happened. If you're comfortable with git, please refer to
the following document on how to isolate the changeset that causes the
problem: http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

                                    Pekka
