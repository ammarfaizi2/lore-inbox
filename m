Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBIH2T>; Fri, 9 Feb 2001 02:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBIH2J>; Fri, 9 Feb 2001 02:28:09 -0500
Received: from [210.212.54.4] ([210.212.54.4]:60165 "EHLO mail.cse.iitk.ac.in")
	by vger.kernel.org with ESMTP id <S129026AbRBIH2G>;
	Fri, 9 Feb 2001 02:28:06 -0500
Date: Fri, 9 Feb 2001 00:11:26 +0530 (IST)
From: Avinash vyas <avyas@cse.iitk.ac.in>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, kernelnewbies@humbolt.nl.linux.org,
        "Atul Kumar (9721171)" <ak@cse.iitk.ac.in>,
        "Rajiv A.R" <rajiva@cse.iitk.ac.in>
Subject: Re: Problem with schedule_timeout..
In-Reply-To: <E14QqLB-0003RI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10102090006280.1187-100000@csews5.cse.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
	Yes the problem was what Sir Alan Cox told, when i called my
device driver poll function after making the TASK_INTERRUPTIBLE, it made
the process state again to RUNNING (In a rpc_call() function).

Thanx

                 ########################################
                 #     Avinash Vyas                     #
                 #     M.Tech. CSE                      #
                 #     IIT Kanpur                       #
                 #                                      #                 
                 #   Address: C-302,                    #
                 #            Hall IV,                  #
                 #            IIT Kanpur.               #
                 #   E-mail: avyas@cse.iitk.ac.in       #
                 #           avyas@iitk.ac.in           #
                 #                                      #
                 ########################################




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
