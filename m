Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbRGKIpQ>; Wed, 11 Jul 2001 04:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbRGKIpB>; Wed, 11 Jul 2001 04:45:01 -0400
Received: from [202.140.153.5] ([202.140.153.5]:38927 "EHLO
	techctd.techmas.hcltech.com") by vger.kernel.org with ESMTP
	id <S267234AbRGKIoF>; Wed, 11 Jul 2001 04:44:05 -0400
Message-ID: <3B4C126E.8085BDD@techmas.hcltech.com>
Date: Wed, 11 Jul 2001 14:16:38 +0530
From: "N. Varadarajan" <varadhu_n@techmas.hcltech.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel Linux <linux-kernel@vger.kernel.org>,
        Vasu Varma P V <pvvvarma@techmas.hcltech.com>
Subject: [Fwd: Re: Total RAM in the system]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Mike,
i tried that already on a 2.2.18 kernel and
num_physpages is not
exported. num_physpages does not contain the
actual RAM present
in the system.

i booted up my linux with command line parameter
mem=32M,
but my machine actually had 128M RAM. and from KDB
i inspected
num_physpages which showed me only 32M

thanx

Mike Galbraith wrote:
> 
> On Wed, 11 Jul 2001, N. Varadarajan wrote:
> 
> > Hi,
> > Is there a way to know the amount of physical RAM
> > present in the system from a loadable kernel
> > module
> 
> Yes.. num_physpages is an exported symbol.
> 
>         -Mike
