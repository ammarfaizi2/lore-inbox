Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284680AbRLDAVJ>; Mon, 3 Dec 2001 19:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284664AbRLDAOw>; Mon, 3 Dec 2001 19:14:52 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:55184 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S284716AbRLCP7L>; Mon, 3 Dec 2001 10:59:11 -0500
Message-ID: <3C0BA20F.946E0F1B@nortelnetworks.com>
Date: Mon, 03 Dec 2001 11:02:23 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: possible to do non-blocking write to NFS?
In-Reply-To: <200010131722.e9DHMwL17616@pincoya.inf.utfsm.cl> <39EC6F4E.8FC87501@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any way to write to an NFS-mounted filesystem in a way that will avoid
all of the NFS retries?  Basically I want to try a write, and if the server is
not accessable I want to return immediately with an error code.

Would setting the O_NONBLOCK flag on opening the file give me this behaviour?

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
