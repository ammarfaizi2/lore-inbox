Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSK0Igd>; Wed, 27 Nov 2002 03:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSK0Igd>; Wed, 27 Nov 2002 03:36:33 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:11875 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S261663AbSK0Igc>;
	Wed, 27 Nov 2002 03:36:32 -0500
Message-ID: <3DE485C5.8080309@debian.org>
Date: Wed, 27 Nov 2002 09:43:49 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
References: <fa.gaum5rv.1j3snhh@ifi.uio.no> <fa.ivlir9v.u14v3p@ifi.uio.no>
In-Reply-To: <fa.gaum5rv.1j3snhh@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 08:43:50.0147 (UTC) FILETIME=[1B89D530:01C295F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> This demonstrates a very important point - _any_ automatic
> configuration program is likely to cause more traffic to this mailing
> list, and create more work for users and developers that the current
> automatic configuration process:
>
> echo 'My box doesn't boot' | mail linux-kernel@vger.kernel.org
>
> The kernel knows nothing about motherboards, cards, etc.  It knows
> about chipsets, and nothing else.  By definition, you cannot have a
> kernel configurator that works at a higher level than that.

I disagree. When we have a booting kernel, finding out the used drivers
is not so difficult: kernel give us already enough informations (modules
loaded, in drivers that use some resources,...).

The problem is: what will be the use of such minimalistic/optimal but
non-modular kernel?
If I add a new device (such a modem, a printer, new USB device...) or
if I use a new disk with an other FS, the users of an autoconfiguration
will be lost, but not the users of the vendors kernels.

Thus the real problem is: where will use such autoconfiguration? Why?
IMHO it can be used only by expert, to find what drivers is need for
such device (when hotplug cannot help you).

ciao
	giacomo

