Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTLKPC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTLKPC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:02:29 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:60922 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265081AbTLKPC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:02:26 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 09:01:55 -0600
X-Mailer: KMail [version 1.2]
Cc: Paul Zimmerman <zimmerman.paul@comcast.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100636100.3805-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10312100636100.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <03121109015500.01687@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 11:58, Andre Hedrick wrote:
> Jesse,
>
> Linking to become one with the vmlinux (zen thing) or not able to achieve
> a modular state, you are toast.  Loading a module is not linking.  Now
> people claim that /proc/kcore is where the dirty work happens.

So loading a module doesn't include it in any tables, and hence modifies them?
It doesn't provide or accept relocation information to alter address
references?
It doesn't need to be invoked by the kernel?

Looks nonfunctional to me.

> Is "/proc/kcore" real?
>
> What makes it real?  Who makes it real?
>
> If you, the user of the binary module, execute:
>
> 	cat /proc/kcore > /kcore.file
>
> Who combined the works?

Not relevent. Everything is done in user mode using defined user mode
interfaces for kernel/user mode separation.


