Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWDIBbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWDIBbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 21:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWDIBbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 21:31:04 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:30400 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965055AbWDIBbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 21:31:01 -0400
From: Dan Dennedy <dan@dennedy.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Date: Sat, 8 Apr 2006 18:25:53 -0700
User-Agent: KMail/1.9
Cc: linux1394-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       scjody@modernduck.com, linux-kernel@vger.kernel.org
References: <20060406224706.GD7118@stusta.de> <200604081218.24544.dan@dennedy.org> <443813C4.9090000@s5r6.in-berlin.de>
In-Reply-To: <443813C4.9090000@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604081825.53461.dan@dennedy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2006 12:49, Stefan Richter wrote:
> Dan Dennedy wrote:
> > can nag someone at Fluendo. I think another high profile app that might
> > be affected is GnomeMeeting/Ekiga, but I have not kept close track of it.
> >
> It appears from grep'ing through the sources of Ekiga 2.0.1 that it does
> not access (lib)raw1394 by itself.

I just checked, and it is actually in the openh323 pwlib's vidinput_avc 
module.
