Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAOT7c>; Mon, 15 Jan 2001 14:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAOT7W>; Mon, 15 Jan 2001 14:59:22 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:16915 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129632AbRAOT7Q>;
	Mon, 15 Jan 2001 14:59:16 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101151959.f0FJxDB248265@saturn.cs.uml.edu>
Subject: Re: 2.4.0-x features ?
To: pierre.rousselet@wanadoo.fr (Pierre Rousselet)
Date: Mon, 15 Jan 2001 14:59:13 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A628870.EA2C3BF9@wanadoo.fr> from "Pierre Rousselet" at Jan 15, 2001 06:19:44 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:

> 1) top (procps-2.0.7) gives me the messages :
> 'bad data in /proc/uptime'
> 'bad data in /proc/loadavg'
> cat /proc/uptime 
> 1435.30 904.74
> cat /proc/loadavg
> 0.01 0.21 0.29 1/17 19444
> What is wrong ?

Which 2.4.0-x kernel, and how was procps compiled?
(the broken gcc again perhaps?)

You might as well get procps-010114.tar.gz (new just yesterday!) and
compile it yourself. The top command seems to tolerate Red Hat's
fixed gcc, which you should get if you are using Red Hat 7.

http://www.cs.uml.edu/~acahalan/procps/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
