Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVAFNav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVAFNav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVAFNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:30:50 -0500
Received: from alog0039.analogic.com ([208.224.220.54]:15232 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262819AbVAFNag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:30:36 -0500
Date: Thu, 6 Jan 2005 08:30:25 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Frey <jan.frey@nokia.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for gzipped (ELF) core dumps
In-Reply-To: <1105017578.28175.1.camel@borcx178>
Message-ID: <Pine.LNX.4.61.0501060826060.17938@chaos.analogic.com>
References: <1105017578.28175.1.camel@borcx178>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Jan Frey wrote:

> Hi,
>
> I've written a patch for 2.4.28 kernel which enables writing of core
> dump files for ELF binaries in .gz format. This is interesting when
> using and debugging large binaries. In my case core files exceeded 1GB
> and got written via NFS...
> Anyhow, below patch is not really "beautiful", especially CRC looks
> quite annoying here. Consequently it is to be seen as "proof of concept"
> and I'm open for further discussion.
>
> Is anybody else interested in something like this at all?
>
> Regards,
> Jan

But that's what modules are for! It would nice to have a module
that could be inserted when the capability is needed. Certainly
you don't expect everybody to keep those unused CRC tables in
the kernel forever. Do you?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
