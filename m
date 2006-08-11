Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHKPcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHKPcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHKPcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:32:43 -0400
Received: from c3po.0xdef.net ([217.172.181.57]:19209 "EHLO c3po.0xdef.net")
	by vger.kernel.org with ESMTP id S1751191AbWHKPcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:32:42 -0400
Date: Fri, 11 Aug 2006 17:32:39 +0200
From: Hagen Paul Pfeifer <hagen@jauu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Process Communication Mechanisms
Message-ID: <20060811153239.GA20436@c3po.0xdef.net>
Mail-Followup-To: Hagen Paul Pfeifer <hagen@jauu.net>,
	linux-kernel@vger.kernel.org
References: <75fdd94c0608110425w40493f48u2ef6d73ed3f6dec1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <75fdd94c0608110425w40493f48u2ef6d73ed3f6dec1@mail.gmail.com>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kamran Soomro | 2006-08-11 16:25:43 [+0500]:

>Hi. I want to study how the 2.6 kernel handles process communication.
>I am planning to study the source code for this purpose. Can someone
>please guide me as to where to start? And how to proceed. Thanks.

Process Communication in the sense of SYS V? Then the complete ipc directory
[1] will be your friend.

For Unix sockets the implementation is a little bit more complicated - you must
grasp more source-code. But this depends on how deep is your interesting.

Last but not least: there are many books out there who cover this topic.


[1] http://lxr.linux.no/source/ipc/
