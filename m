Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129928AbRBHM11>; Thu, 8 Feb 2001 07:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBHM1S>; Thu, 8 Feb 2001 07:27:18 -0500
Received: from [210.212.54.4] ([210.212.54.4]:35342 "EHLO mail.cse.iitk.ac.in")
	by vger.kernel.org with ESMTP id <S129928AbRBHM1D>;
	Thu, 8 Feb 2001 07:27:03 -0500
Date: Thu, 8 Feb 2001 17:55:56 +0530 (IST)
From: Avinash vyas <avyas@cse.iitk.ac.in>
To: linux-kernel@vger.kernel.org
cc: kernelnewbies@humbolt.nl.linux.org,
        "Atul Kumar (9721171)" <ak@cse.iitk.ac.in>,
        "Rajiv A.R" <rajiva@cse.iitk.ac.in>
Subject: Problem with schedule_timeout..
Message-ID: <Pine.LNX.4.10.10102081745140.758-100000@csews5.cse.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I am a relatively newb in the kenel programming. I am using the
function "schedule_timeout" for sleeping for some time. But in some cases
the function returns after the specified timeout but in some instance it
returns immediately, without decrementing the timeout value passed as the
argument. 
	I have to use this function only, so please suggest what can be
the possible reasons.

	The above said instance occured when i was developing a device
driver, where i am implementing the poll. The function do_poll() uses this
function for sleeping for specified timeout value. In normal device
drivers it runs as it should, but when i poll on my device then the
function returns immediately. I used the same timeout value for both the
polls.

Thanx in advance,
Avinash Vyas,
Student,
IIT Kanpur, 
India.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
