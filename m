Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTIRLN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTIRLN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:13:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261152AbTIRLN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:13:57 -0400
Date: Thu, 18 Sep 2003 07:15:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: Small security option
In-Reply-To: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
Message-ID: <Pine.LNX.4.53.0309180709420.2371@chaos>
References: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003, John R Moser wrote:

> Why wasn't this done in the first place anyway?
>
> Some sysadmins like to disable the other boot devices and password-protect
> the bios.  Good, but if the person can pass init=, you're screwed.
>
> Here's a small patch that does a very simple thing: Disables "init=" and
> using /bin/sh for init. That'll stop people from rooting the box from grub.
>
> The file is attatched.

No. I can still boot your box, mount your root file-system, and
change the root password, all without you even knowing it.
If I have physical control of a computer, I own it. I can
do anything I want with it. If you could really prevent
somebody from "breaking in", then you can never sell it and
you are screwed if the password file gets corrupt (you would have
to throw everything away).

This patch is not useful.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


