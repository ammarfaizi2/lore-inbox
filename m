Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317467AbSFDJoK>; Tue, 4 Jun 2002 05:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSFDJoJ>; Tue, 4 Jun 2002 05:44:09 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:34312 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317467AbSFDJoJ>;
	Tue, 4 Jun 2002 05:44:09 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Brian C. Huffman" <huffman@graze.net>
Date: Tue, 4 Jun 2002 11:43:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: kernel routing of IPSec / VMWare
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <71CBDC94409@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jun 02 at 1:19, Brian C. Huffman wrote:
> 
> The way that we have checkpoint setup it is doing UDP encapsulation of
> the IPSec (otherwise it would not be possible to do this w/ NAT).  This
> is with all the latest 2.4 kernels (haven't tried 2.4.19, though). 

Can't you push packets over your eth0 MTU with this encapsulation?
It would be useful if you could do 'tcpdump -i vmnet8 & tcpdump -i eth0'
or 'tcpdump -i any' to find what's going on.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

P.S.: Did you tried to ask in VMware newsgroups?
                                                    
