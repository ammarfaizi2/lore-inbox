Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIQyS>; Tue, 9 Jan 2001 11:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRAIQyI>; Tue, 9 Jan 2001 11:54:08 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:10509 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S129431AbRAIQxu>;
	Tue, 9 Jan 2001 11:53:50 -0500
Date: Tue, 9 Jan 2001 11:53:02 -0500
From: Tim Sailer <sailer@bnl.gov>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network Performance?
Message-ID: <20010109115302.A32135@bnl.gov>
In-Reply-To: <20010104013340.A20552@bnl.gov>, <20010104013340.A20552@bnl.gov>; <20010105140021.A2016@bnl.gov> <3A56FD6C.93D09ABB@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A56FD6C.93D09ABB@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jan 06, 2001 at 10:11:40PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some more data:

        Inbound = 99.66 kB/s
        Outbound= 151 kB/s


--------------------------------------------
ports:/home/ftp# sysctl -a | fgrep net/core
net/core/optmem_max = 10240
net/core/message_burst = 50
net/core/message_cost = 5
net/core/netdev_max_backlog = 300
net/core/rmem_default = 32767
net/core/wmem_default = 32767
net/core/rmem_max = 2097152
net/core/wmem_max = 2097152
--------------------------------------------


Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
