Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131286AbRCRXUl>; Sun, 18 Mar 2001 18:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131297AbRCRXUW>; Sun, 18 Mar 2001 18:20:22 -0500
Received: from 24dyn111.com21.casema.net ([213.17.94.111]:64530 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131286AbRCRXUH>;
	Sun, 18 Mar 2001 18:20:07 -0500
Date: Mon, 19 Mar 2001 00:18:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: right way to export VM data to userspace for a performance tool
Message-ID: <20010319001825.A13169@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I want to write a tool that can extract information from the kernel about
the VM situation. Conceptually, I want something that looks like this:

# cacheinfo /var/mysql/data/powerdns/records.MYD
75% of blocks in memory
12% dirty
# cacheinfo -d -v /var/mysql/data/powerdns/records.MYD
0	M
1	M
2	-
3	-
4	D
....

Before writing this, I'm wondering how the kernel people feel that this sort
of information should be exported to userland. There are lots of options,
but not being a kernel architect/philosopher, I don't have a clue.

My goal is to have a patch included in the main kernel, so it is very
important that I write stuff people will agree on.

Please let me know what you think.

Kind regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
