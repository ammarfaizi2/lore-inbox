Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTFPWhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTFPWhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:37:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61937 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264393AbTFPWhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:37:03 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: Daniel Stekloff <stekloff@us.ibm.com>, janiceg@us.ibm.com,
       jgarzik@pobox.com, kenistonj@us.ibm.com,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Mon, 16 Jun 2003 17:50:08 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/16/2003 18:50:41
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David S. Miller <davem@redhat.com>
   Date:06/16/2003 05:27 PM

   And all the scripts checking for the existing messages in log files?
   Screw them, right?

That's a good point.  One possible suggestion would be to submit more than
one stdmsgs.h files.  One a legacy file, and one that is more consistent
from message to message.. shooting for a gradual migration.

Ultimately, I think standard messages would greatly support/simplify
scripts, especially between the myriad of ethernet drivers.  Each one
reports the data slightly differently, so you're error log analysis needs
to recognize 100 or so ways of being told that the link just went down.

Janice






                                                                                                                         
                      "David S. Miller"                                                                                  
                      <davem@redhat.com        To:       Janice Girouard/Austin/IBM@IBMUS                                
                      >                        cc:       Daniel Stekloff/Beaverton/IBM@IBMUS,                            
                                                janiceg@us.ltcfwd.linux.ibm.com, jgarzik@pobox.com,                      
                      06/16/2003 05:27          kenistonj@us.ibm.com, Larry Kessler/Beaverton/IBM@IBMUS,                 
                      PM                        linux-kernel@vger.kernel.org, netdev@oss.sgi.com,                        
                                                niv@us.ltcfwd.linux.ibm.com                                              
                                               Subject:  Re: patch for common networking error messages                  
                                                                                                                         
                                                                                                                         




   From: Janice Girouard <girouard@us.ibm.com>
   Date: Mon, 16 Jun 2003 17:29:15 -0500

   For the sake of consistency and automatic error log analysis, it might
be

And all the scripts checking for the existing messages
in log files?  Screw them, right?

This whole idea is starting to leave a very bad taste in
my mouth...




