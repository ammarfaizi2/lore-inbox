Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTIRPfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTIRPfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:35:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56704 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261537AbTIRPf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:35:26 -0400
Date: Thu, 18 Sep 2003 11:37:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alexandru Damian <ddalex_krn@easynet.ro>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of sockets...
In-Reply-To: <3F69CD40.20106@easynet.ro>
Message-ID: <Pine.LNX.4.53.0309181134140.5425@chaos>
References: <3F69CD40.20106@easynet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003, Alexandru Damian wrote:

>
>
>    It may seem a pretty stupid question, but what do I need to
> modify in a 2.4.22 kernel to increase the maximum number of sockets
> available to userland programs.
>
> Thanks,
> Alex
>

Maybe you just need to set new per-process open file limits?

socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1015
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1016
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1017
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1018
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1019
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1020
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1021
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1022
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 1023
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = -1 EMFILE (Too many open files)


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


