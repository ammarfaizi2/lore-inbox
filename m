Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269017AbTCAUYG>; Sat, 1 Mar 2003 15:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbTCAUYG>; Sat, 1 Mar 2003 15:24:06 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:35819 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S269017AbTCAUYF>; Sat, 1 Mar 2003 15:24:05 -0500
Message-ID: <3E611959.7090507@sixbit.org>
Date: Sat, 01 Mar 2003 15:34:33 -0500
From: John Weber <weber@sixbit.org>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 wireless loading problem
References: <Pine.LNX.4.44.0302281955380.2070-200000@localhost.localdomain> <20030228181158.A1745@sonic.net>
In-Reply-To: <20030228181158.A1745@sonic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:
> On Fri, Feb 28, 2003 at 07:59:47PM -0600, Thomas Molina wrote:
> 
> 
>># CONFIG_ISA is not set
> 
> 
> The PCMCIA drivers decide whether or not ISA interrupts are available
> based on CONFIG_ISA so you should turn this on.
> 
> Perhaps this is a misuse of this configuration option.  I'm not sure
> what's the right thing to do.

How about calling it "PCI<->PCMCIA bridge support" and making it a 
sub-menu of CONFIG_PCI?


