Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317092AbSFBAu1>; Sat, 1 Jun 2002 20:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317093AbSFBAu0>; Sat, 1 Jun 2002 20:50:26 -0400
Received: from holomorphy.com ([66.224.33.161]:31648 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317092AbSFBAu0>;
	Sat, 1 Jun 2002 20:50:26 -0400
Date: Sat, 1 Jun 2002 17:50:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4 hyperthreading
Message-ID: <20020602005003.GE14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1022978449.2197.10.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 08:40:44PM -0400, Louis Garcia wrote:
> How stable is hyperthreading under kernel-2.4.18? I compiled the kernel
> for the Pentium4 and dmesg shows CPU0 and CPU1, but CPU1 is disabled.
> How do I enable CPU1 and should I?? Do other libraries need to be updated
> or is hyperthreading like having a two processor box?

acpismp=force seems to work on 2.4 here.


Cheers,
Bill
