Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRC0T0u>; Tue, 27 Mar 2001 14:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRC0T0l>; Tue, 27 Mar 2001 14:26:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:36567 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131497AbRC0T02>;
	Tue, 27 Mar 2001 14:26:28 -0500
From: "Richard A. Smith" <rsmith@bitworks.com>
To: "andre@linux-ide.org" <andre@linux-ide.org>
Cc: "Padraig@AnteFacto.com" <Padraig@AnteFacto.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 27 Mar 2001 13:25:02 -0600
Reply-To: "Richard A. Smith" <rsmith@bitworks.com>
X-Mailer: PMMail 2000 Professional (2.20.2030) For Windows 98 (4.10.2222)
In-Reply-To: <Pine.LNX.4.10.10103270912130.16125-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Compact flash disk and slave drives in 2.4.2
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: RSmith@bitworks.com
Message-ID: <MDAEMON-F200103271328.AA284497MD89819@bitworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001 09:17:48 -0800 (PST), Andre Hedrick wrote:

>not acceptable.  If you have a complain take it to CFA commitee and have
>them fix it.

Well my only real complaints are that 1) It was done silently.. 2) I could not override it 
w/o a code mod.  Both of which are contrary to what I am accustom to when using linux.

>Logically treated, is true, but again CFA does not follow the rules of
>what the ATA committee gives them, and I refuse to break rules as the
>standard model.  Rule breaking are exceptions.
>
>Also show me a case where a laptop will do master/slave in CFA.

Agreed... If CF does some wierd stuff then you shouldn't make the ATA driver break any 
rules for it.. that wasn't what I was asking for.  Just some why's and perhaps a message 
that indicated what it was doing.

As for the laptops.. What laptops are you refering to?  Don't most of them have some sort 
of std laptop HD or an ibm microdrive thing.  CF is terribly expensive compared to 
mechanical HDs.

>/linux/drivers/ide/ide.c
>* "hdx=flash"          : allows for more than one ata_flash disk to be
>*                              registered. In most cases, only one device
>*                              will be present.

Perhaps I missed something.. but this won't work for my original case.  I have a CF as hda 
and I was trying to hook up a mechanical HD as the slave.  I specified hdb=c,h,s on the 
command line but it was ignored.


--
Richard A. Smith                         Bitworks, Inc.               
rsmith@bitworks.com               501.846.5777                        
Sr. Design Engineer        http://www.bitworks.com   


