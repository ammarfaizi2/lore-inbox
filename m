Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264494AbRFZVCr>; Tue, 26 Jun 2001 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbRFZVCh>; Tue, 26 Jun 2001 17:02:37 -0400
Received: from imo-m10.mx.aol.com ([64.12.136.165]:56292 "EHLO
	imo-m10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S264469AbRFZVCW>; Tue, 26 Jun 2001 17:02:22 -0400
Date: Tue, 26 Jun 2001 17:02:12 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: about get_zeroed_page() and page_address()
Mime-Version: 1.0
Message-ID: <2BC44B50.39C55AFA.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the get_zeroed_page()function, address = page_address(page)
1)Does address point to a contiguous block of 4KB of physical memory?     i.e.can I access the individual bytes by *address++?
2)How is page_address() function defined? I did a grep and found something like: #define page_address(page) ({ if (!(page)->virtual) BUG(); (page)->virtual; })? What's (page)->virtual?

Thanks
Any help would be greatly appreciated.

__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
