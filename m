Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWGRPVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWGRPVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGRPVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:21:54 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:45279 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932242AbWGRPVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:21:54 -0400
Subject: Re: Bad ext3/nfs DoS bug
From: Marcel Holtmann <marcel@holtmann.org>
To: James <20@madingley.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060718145614.GA27788@circe.esc.cam.ac.uk>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	 <1153209318.26690.1.camel@localhost>
	 <20060718145614.GA27788@circe.esc.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 17:22:16 +0200
Message-Id: <1153236136.10006.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > so I used your exploit and I could reproduce it on every 2.6 kernel, I
> > tried so far. 
> 
> That must have been a lot of fscks.

it wasn't that many. For some obvious reasons I only tested the RHEL and
Fedora kernels and vanilla plus stable series.

> > However with a 2.4 kernel I see the error messages, but it
> > doesn't get remounted read-only. Did you run tests with 2.4 kernels?
> 
> no, I don't have any to hand, but someone is preparing one
> now. Is NFS subtree checking on by default in 2.4?

I haven't checked within the code, but the manual page exports(5) states
subtree checking as being on by default. And it doesn't mention any
difference to 2.4 kernels.

What is the reason behind your question? Does disabling subtree checking
changes something?

Regards

Marcel


