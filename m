Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTEaLik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTEaLik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:38:40 -0400
Received: from tag.witbe.net ([81.88.96.48]:11789 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264283AbTEaLii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:38:38 -0400
From: "Paul Rolland" <rol@witbe.net>
To: <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: warning: process 'update' used the obsolete bdflush...
Date: Sat, 31 May 2003 13:51:59 +0200
Organization: Witbe.net
Message-ID: <008001c3276b$0b0a6380$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200305311053.h4VArbVW001936@harpo.it.uu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Sat, 31 May 2003 11:04:20 +0200, Paul Rolland wrote:
> >When switching from 2.4.20 to 2.5.x (x being recent), I have this 
> >message...
> >
> >What does this mean ?
> >1 - I have no process named update running,
> >2 - I can't find anything name update in /etc/rc.d/* recursively.
> 
> If you have a line with 'update' or 'bdflush' in 
> /etc/inittab, remove it. (Its obsolete since mid-2.2 or so.)

Nice guess ! I have 
ud:once:/sbin/update 
within inittab.

The puzzling part is that, if it obsolete since mid-2.2, why is it
present on a RedHat 8.0 install ?

However, this question is not important ;-)

Thanks for the info, I'm gonna clean this !

Regards,
Paul

