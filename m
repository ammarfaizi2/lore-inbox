Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTLGSDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGSDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:03:50 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:8599 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S264472AbTLGSDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:03:49 -0500
Date: Sun, 7 Dec 2003 10:03:48 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Russell \"Elik\" Rademacher" <elik@webspires.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading - Found the answers
In-Reply-To: <18715758953.20031204161441@webspires.com>
Message-ID: <Pine.LNX.4.58.0312071000250.6155@twinlark.arctic.org>
References: <18715758953.20031204161441@webspires.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Dec 2003, Russell "Elik" Rademacher wrote:

> Hello linux-kernel,
>
>   Thanks folks.  Apparently, the documentations are little buried under
> but apparently, needed to have boot time parameter as follows:
> acpismp=force to have the hyperthreading to show up properly.

fwiw, on my xeon box i need to use "acpi=ht" or else the acpi code causes
80000 interrupts per second, even when idle.  (this is with 2.4.22, on a
tyan 2723 with whatever their latest bios was as of three or four months
ago.)

-dean
