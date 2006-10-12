Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWJLUZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWJLUZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWJLUZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:25:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50122 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750856AbWJLUZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:25:58 -0400
Message-ID: <474c7c2f0610121325j23320d36i20c71ccaa04645d9@mail.gmail.com>
Date: Thu, 12 Oct 2006 16:25:57 -0400
From: "=?UTF-8?Q?G=C3=BCnther_Starnberger?=" <gst@sysfrog.org>
To: jplatte@naasa.net
Subject: Re: Userspace process may be able to DoS kernel
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <200610122211.16202.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <200610121341.56325.lists@naasa.net>
	 <84144f020610120457g221b8736vebf2f0a634480c05@mail.gmail.com>
	 <200610122211.16202.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Joerg Platte <lists@naasa.net> wrote:

> Not that easy, since it takes a few hours to be able to trigger the bug. I
> tried to record the system calls with strace but without success. Skype did
> not cause any lockups and then crashes... Maybe the timing is too different
> with strace.

According to [1] there are several anti-debugging techniques used in
Skype. I.e. if it notices some sort of debugger it will crash (on
purpose).

bye,
/gst

[1] www.blackhat.com/presentations/bh-europe-06/bh-eu-06-biondi/bh-eu-06-biondi-up.pdf
