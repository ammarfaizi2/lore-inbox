Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbQKCShx>; Fri, 3 Nov 2000 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131204AbQKCShn>; Fri, 3 Nov 2000 13:37:43 -0500
Received: from [47.140.48.50] ([47.140.48.50]:45250 "EHLO
	zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S130565AbQKCShY>; Fri, 3 Nov 2000 13:37:24 -0500
Message-ID: <3A02F7C4.E140D608@nortelnetworks.com>
Date: Fri, 03 Nov 2000 12:37:08 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to get IP address of current machine from C++ code?
In-Reply-To: <200010210246.WAA08580@smarty.smart.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to get the IP address of one of the interfaces of the
machine that I'm currently on from within some C++ code.  It looks like
I should be able to do this by doing an

ioctl(atoi(fd, SIOCGIFADDR, &ifr)

with the interface name set in the appropriate field in ifr, but I'm not
sure how I should be getting the proper value for fd.  I would
appreciate some help on this, or if there is a better way then I'd love
to hear it.

Thanks,

Chris


--
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
