Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310681AbSCTBF6>; Tue, 19 Mar 2002 20:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310943AbSCTBFs>; Tue, 19 Mar 2002 20:05:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29086 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S310681AbSCTBFe>;
	Tue, 19 Mar 2002 20:05:34 -0500
Message-ID: <3C97DF38.2060307@lnxw.com>
Date: Tue, 19 Mar 2002 17:00:40 -0800
From: Petko Manolov <pmanolov@Lnxw.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020314
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com, Andreas Dilger <adilger@clusterfs.com>,
        John Jasen <jjasen1@umbc.edu>, Mike Galbraith <mikeg@wen-online.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <E16nU3k-0000oJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>The data sent/received on the network is precious. You will not have
>>any 'extra' data on its end except for possibly a single byte if the

You will have padding if the ethernet packet is less than 60 bytes and
if necessary it will be more than a single byte. I am not sure what is
the value of the paddin bythes though.  May be zero..


		Petko

