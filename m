Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUCJVfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUCJVfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:35:05 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:6306 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262846AbUCJVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:35:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <404F6375.3080500@blue-labs.org>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos> <Pine.LNX.4.53.0403101324120.18709@chaos> <404F6375.3080500@blue-labs.org>
Message-Id: <E1B1BLv-0004f5-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 10 Mar 2004 21:34:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

>Really, your mail reading software should be capable of wrapping things 
>by itself, we really have progressed from yesteryear.

The issue is that there are two types of text. The message itself should
be wrapped, whereas inline code may be semantically changed by being
wrapped. If both are streams of text with no embedded newlines then
there's no way of telling the difference between them, whereas if one
has embedded newlines then the choice of wrapping the other can be made
by the recipient. The alternative would result in both being wrapped,
which isn't the behaviour I want. Having lines that are slightly shorter
than ideal on some people's screens seems the lesser of two evils.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
