Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTFZXGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFZXGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:06:06 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:62226 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263319AbTFZW7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:59:13 -0400
Message-ID: <3EFB7E90.1090902@techsource.com>
Date: Thu, 26 Jun 2003 19:15:28 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: joe briggs <jbriggs@briggsmedia.com>, Edward Tandi <ed@efix.biz>,
       reiser@namesys.com, Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
References: <BB1F47F5.17533%kernel@mousebusiness.com> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz> <200306260825.54076.jbriggs@briggsmedia.com> <20030626115525.GA13194@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oleg Drokin wrote:

> Is not this is one of those heavy-PCI loaded boxes that ocasionally corrupt
> data when PCI is overloaded? 
> The log you quoted shows that suddenly tree nodes have incorrect content
> (and the i/o error is because reiserfs does not know what to do with such nodes).
> (and we hope to push the patch that will print device where error have occured
> soon).


The PCI spec doesn't allow more than four slots per bus.  Some boards 
try to put on 5 or 6 slots anyhow, violating the spec.  It's no wonder 
there are so many problems with those boards.

You can often get them to work anyhow, but it involves swapping cards 
around in slots until you find an arrangement that works, but it's still 
unreliable.


