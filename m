Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUGBNvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUGBNvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGBNvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:51:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57984 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264541AbUGBNvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:51:36 -0400
Date: Fri, 2 Jul 2004 09:51:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Handling Signals in the driver
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348110387AB@mail.esn.co.in>
Message-ID: <Pine.LNX.4.53.0407020949550.3789@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348110387AB@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004, Srinivas G. wrote:

> Hi All,
>
> Is there any method to send a signal from device driver to a Daemon
> Process?
>
> Actually I have written a program to generate a daemon process. It was
> working fine. I developed the application to send a signal to my daemon
> to perform some action based on the signal. It was also working fine.
> Now my intention is to send a signal from a device driver to the daemon
> process. Is it possible?
>
> I am not very sure of how to achieve this.
> Please help me address this issue.
>
> Thank in advance,
>
> Srinivas G

kill_proc(pid, SIGNAL, 1);

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


