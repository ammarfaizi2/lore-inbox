Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUHaWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUHaWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbUHaWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:09:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:8126 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268137AbUHaWDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:03:16 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: greg@kroah.com, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040831215831.GA3573@taniwha.stupidest.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831215831.GA3573@taniwha.stupidest.org>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 18:02:44 -0400
Message-Id: <1093989764.4815.52.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 14:58 -0700, Chris Wedgwood wrote:

> I *still* thinking putting all the possible messages into something
> like include/linux/kevent_msg.h is a good idea to prevent people
> creating all sorts of stupid ad-hoc messages over time that userspace
> will ineviitably not be able to track....

I still agree, but since that does not change the API (I'd still want
the signal to be a string) that bit can come later when there are real
users.  Or I will take a patch now. ;-)

Since we ditched the payload, the only thing left is the signal, which
is going to be "changed" half the time anyhow.

	Robert Love


