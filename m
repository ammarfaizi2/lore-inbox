Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVDAP0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVDAP0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVDAPYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:24:51 -0500
Received: from smtp8.poczta.onet.pl ([213.180.130.48]:40851 "EHLO
	smtp8.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262772AbVDAPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:24:29 -0500
Message-ID: <424D6821.4010709@poczta.onet.pl>
Date: Fri, 01 Apr 2005 17:26:25 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no>	<E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>	<424ACEA9.6070401@poczta.onet.pl>	<yw1xpsxhvzsz.fsf@ford.inprovide.com>	<424AE18B.1080009@poczta.onet.pl>	<yw1xll85vtva.fsf@ford.inprovide.com>	<424B090F.3090508@poczta.onet.pl> <yw1xhdisx3th.fsf@ford.inprovide.com>
In-Reply-To: <yw1xhdisx3th.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> 
> So you are proposing the addition of a per-file attribute, with
> restricted access, and potentially dangerous effects if set
> incorrectly.  This, combined with the fact that is unlikely to receive
> much testing, all speaks against it.
> 

Almost every attribute can be dangerous if set incorrectly. Bot it is 
really no problem - simply let's turn to fat12 as root filesystem, and 
no attribute will be dangerous any more... See that acl-s also are not 
used for every file, only for some files, ones of thousands files in the 
filesystem. They are not set and reset every ten minutes - they are set 
one time and used, used and used. The same applies to nice attribute. Is 
it dangerous to not modify attribute all the time? And why restricted 
access is riskfull and evil? If restriction of sccess makes system more 
vurnable to attacks, maybe the good solution will be to set 755 
attributes on enery inode (expecially /etc/shadow) - then everyone will 
be able to do everything and system as whole will be more secure...

I really don't catch your mind.

--
wixor
May the Source be with you.
