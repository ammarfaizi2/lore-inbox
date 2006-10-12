Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWJLLmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWJLLmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWJLLmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:42:04 -0400
Received: from rosi.naasa.net ([212.8.0.13]:33409 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1750878AbWJLLmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:42:01 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Userspace process may be able to DoS kernel
Date: Thu, 12 Oct 2006 13:41:55 +0200
User-Agent: KMail/1.9.5
Cc: "=?iso-8859-1?q?G=FCnther?= Starnberger" <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200610120802.59077.lists@naasa.net> <84144f020610120430r382bc860t5092ddb2a343d2d9@mail.gmail.com>
In-Reply-To: <84144f020610120430r382bc860t5092ddb2a343d2d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610121341.56325.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. Oktober 2006 13:30 schrieb Pekka Enberg:
Hi,

> On 10/12/06, Joerg Platte <lists@naasa.net> wrote:
> > Using 2.6.18 does not solve the problem. I can see exactly the same
> > behavior with a vanilla and not tainted 2.6.18 kernel.
>
> Do you see this with 2.6.16 also or is it new to 2.6.17?

Hmmm, I deleted all my 2.6.16 kernels and I can't test a newly compiled 2.6.16 
kernel before the weekend. But if I remember correctly, on previous kernel 
versions skype just generates 100% system load when using the sound device 
after some time (especially after a resume) and stuttered audio but no system 
lockups. Hence, it worked much better than now from the kernel point of view 
but was not usable from the skype users point of view. It was a userspace 
only problem.

regards,
Jörg
