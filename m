Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUHZBIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUHZBIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 21:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUHZBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 21:08:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:36250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266650AbUHZBGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 21:06:34 -0400
Date: Wed, 25 Aug 2004 18:06:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       Tim Hockin <thockin@hockin.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Message-ID: <20040825180615.Z1973@build.pdx.osdl.net>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com> <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Wed, Aug 25, 2004 at 08:50:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:
> I would find this much more useful if there was a really lightweight 
> bind
> mount called a "filebind" or somesuch that could only bindmount files 

This already works.

# cd /tmp
# echo foo > a
# touch b
# mount --bind a b
# cat b
foo

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
