Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291212AbSBLV1c>; Tue, 12 Feb 2002 16:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291210AbSBLV1M>; Tue, 12 Feb 2002 16:27:12 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:64524 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S291204AbSBLV1C>; Tue, 12 Feb 2002 16:27:02 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: How to check the kernel compile options ?
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D217218@nasdaq.ms.ensim.com>
Message-Id: <E16akRy-00017e-00@pmenage-dt.ensim.com>
Date: Tue, 12 Feb 2002 13:26:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D217218@nasdaq.ms.ensim.com>,
you write:
>The reason you need all of these config options (which don't end up
>making the code much more complex) is because, for example, if you
>are netbooting your kernel, you do not have access to any external
>data or even the original kernel image on that system.  If it is
>in-memory
>you use 15kB of RAM (5kB in the compressed image) for a fully-configured
>vendor kernel, but you have the config options for THIS kernel and not
>any "maybe it is right, maybe not" external file.

How about having the MD5 sum of the config printed during boot time,
just after (or on) the "Linux version" line - then at least you'd be
able to verify that the .config file in your hands was indeed the one
that was used to compile the kernel.

Paul

