Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUDHIHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbUDHIHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:07:19 -0400
Received: from [69.133.187.210] ([69.133.187.210]:55713 "EHLO
	d10systems.homelinux.com") by vger.kernel.org with ESMTP
	id S264211AbUDHIHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:07:04 -0400
Date: Wed, 7 Apr 2004 23:06:40 -0400 (EDT)
From: Dhruv Gami <gami@d10systems.com>
X-X-Sender: gami@d10systems.homelinux.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setgid - its current use
In-Reply-To: <200404081041.25006.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0404072304500.14350@d10systems.homelinux.com>
References: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com>
 <200404081041.25006.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: gami@d10systems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Denis Vlasenko wrote:

> On Thursday 08 April 2004 04:46, Dhruv Gami wrote:
> > I'd like to know the possibility of using setgid for users to switch their
> > groups and work as a member of a particular group. Essentially, if i want
> > one user, who belongs to groups X, Y and Z to create a file as a member of
> > group Y while he's logged on as a member of group X, would it be possible
> > through setgid() ?
> 
> it is possible through chmod

but that would be an explicit way of doing it, right ? I'm looking for 
doing this via some system calls or something transparent to the user. At 
most I'd like to query the user for the group as which he wants to work. 
Which would essentially be a question I ask at login or beginning of a 
session.

regards,
Gami 

-- 
Dhruv Gami
D10 Systems
http://d10systems.com
http://d10systems.com/gami

