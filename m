Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSFSRXD>; Wed, 19 Jun 2002 13:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSFSRXC>; Wed, 19 Jun 2002 13:23:02 -0400
Received: from otter.mbay.net ([206.55.237.2]:30728 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S313421AbSFSRXB> convert rfc822-to-8bit;
	Wed, 19 Jun 2002 13:23:01 -0400
From: John Alvord <jalvo@mbay.net>
To: Rob Landley <landley@trommello.org>
Cc: zaimi@pegasus.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Date: Wed, 19 Jun 2002 10:22:59 -0700
Message-ID: <l8f1hu0ptese1cie90tnvathd36jqc41ca@4ax.com>
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu> <20020619010945.6725B7D9@merlin.webofficenow.com>
In-Reply-To: <20020619010945.6725B7D9@merlin.webofficenow.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002 15:37:23 -0400, Rob Landley
<landley@trommello.org> wrote:

>On Tuesday 18 June 2002 05:21 pm, zaimi@pegasus.rutgers.edu wrote:
>> Hi all,
>>
>>  has anybody worked or thought about a property to upgrade the kernel
>> while the system is running?  ie. with all processes waiting in their
>> queues while the resident-older kernel gets replaced by a newer one.
>
>Thought about, yes.  At length.  That's why it hasn't been done. :)

IMO the biggest reason it hasn't been done is the existence of
loadable modules. Most driver-type development work can be tested
without rebooting.

john
