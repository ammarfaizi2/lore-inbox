Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVBGBxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVBGBxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 20:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBGBxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 20:53:18 -0500
Received: from sccimhc91.asp.att.net ([63.240.76.165]:59055 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261335AbVBGBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 20:53:15 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Executive Summary: Bad page state at prep_new_page
Date: Sun, 6 Feb 2005 19:53:00 -0600
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061953.00464.jay_roplekar@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might or might not be useful to anybody but I googled with the above  
error and tried to track down how many  of these errors had actually been 
resolved. [It is possible that people don't come back to summarize once the 
problem is resolved]. I only tracked once that did not get reported on lkml.  
And I tried to drill down to get as much info as I can. 


there were 12 in total that I tracked down starting 04/04/04 till 01/26/05
 None had a good resolution reported
 4 out of 12 had extensive memtest runs without any errors.  
12/12 were for 2.6.7-rc3 onwards. 
4/12 had mapping all zeroes [rest did not report or had non-zero mapping]

I might be barking up the wrong tree here without much knowledge,  but
I have a summary gnumeric spreadsheet [which I won't even think of attaching 
here] if it is going to be useful to anyone I would be glad to email 
personally.  It also has html links to the original reports.

Thanks,

Jay

