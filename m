Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUEAS4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUEAS4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUEAS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 14:56:21 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:2995 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261745AbUEASz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 14:55:59 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 01 May 2004 19:55:57 +0100
MIME-Version: 1.0
Subject: Kernel tainting - Binary modules - Proprierty code.
Message-ID: <409400CD.13212.C5637D@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This mail is a not a kernel issue, but after the recent "\0" episode 
I feel I need to 'show all'.  Bear with me please.

I purchased a new Zoom X5 DSL router (Conexant chipset, unknown 
firmware).

It has, and still does have a severe security problem 'as sold' right 
now off the shelf.

My ticket and Zoom Tech replies follow, but AFASIK they don't give 
two bloody hoots about it - and keep closing the ticket as 'solved'.

If this was open source it would be fixed in a few hours (by me 
even!).  As it is, no hope.  But I did fix it by using Micronet 
firmware (alas still closed source) firmware and flashing it (whilst 
closing my eyes).

So, what hope does it give when we find closed source doing stuff 
that it shouldn't and then/but/have closed source binaries as 
modules?

Nick


The full ticket below edited only to remove pertinent info.  Read 
from bottom up.

=============  Zoom Tech Stuff ===============

We have not heard from you concerning your request for support in the 
72
hours since we sent you a response. Consequently, we have changed the
status of your question to SOLVED.


You may also update this question by replying to this message. 
Because
your reply will be automatically processed, you MUST enter your reply 
in
the space below. Text entered into any other part of this message 
will be
discarded. [===> Please enter your reply below this line <===]

[===> Please enter your reply above this line <===]

If your issue remains unresolved, please update this question at
XXXXXXXXXXXXXXXX


Question Reference #040413-000012
---------------------------------------------------------------
              Summary: Security Vunerability - open telnet ports (one
                       passworded, one NOT)
         Product Type: Broadband - DSL Modems
          Sub-Product: ADSL X5 (5554) Ethernet/USB
Category (Issue Type): Driver/Firmware Updates
  Contact Information: nick@nonags.com
         Date Created: 04/13/2004 06:13 AM
         Last Updated: 04/30/2004 03:48 AM
               Status: Solved
       Alternateemail: 


Discussion Thread
---------------------------------------------------------------
Customer (Nick Warne) - 04/26/2004 02:56 PM
Sorry to be a pain, but this cannot be closed as 'solved' until Zoom 
have
release a patched firmware upgrade that fixes the security 
vunerabilities.

Regards,

Nick

Response (Mark S.) - 04/22/2004 04:08 PM
When the firmware is released an email will be sent to 
nick@nonags.com to
notify you.  I have no other workarounds besides directing the open 
ports
to a non-existant ip address.




Thank you

Customer (Nick Warne) - 04/22/2004 02:17 PM
Thanks for reply, and I understand this, but as I already have stated 
I do
not wish to run VS or DMZ as I have 5 Real IP's I serve to the 
Internetet,
therefore NAT and any other type of virtual service/port forward is 
out of
the question.

It needs a fixed firmware update to resolve this properly.

This can be closed, but leave the status as 'unresolved'.

Regards,

Nick

Response (Mark S.) - 04/22/2004 10:17 AM
To setup the Zoom modem and have all the ports stealthed and yet have
Virtual Server function do the following.


If you do not want any ports open simply Enable the DMZ, and add 
10.0.0.2
in the ip address field.  Remove any ports listed in the Virtual 
Server
and save changes and reboot.


If you want specific ports open (80, 3389-Remote Desktop etc) then 
you
must add those port to the Virtual Server and the ip of the machine
hosting the service. Running a port scan test all port are shown as 
except
those added to the Virtual Server.  Trying to access any port that 
you
have added to the Virtual Server will respond on the WAN side
appropriately.





Mark

Customer (Nick Warne) - 04/21/2004 11:26 AM
This is NOT solved.

Zoom Tech have admitted there is a security vunerability as per the
bugtraq announcement.

Zoom Tech admit there is no fix for the Zoom x5.

Zoom Tech admit Conexant have fixed this in their later firmware, but 
have
yet to release to Zoom.

There is NO firmware update from Zoom.

This issue is NOT solved.  It should be 'OPEN'.

Regards,

Nick

Response (Mark S.) - 04/17/2004 03:32 PM
Certainly....this bug was found a short time ago and Conexant 
immediately
started working on the firmware update that will close these ports 
and
make then unresponsive.  


Thank you

Customer (Nick Warne) - 04/15/2004 12:32 PM
OK, thanks for honest reply.

Now, I don't want change this router/modem - it runs and performs 
really
well - is there any likelyhood of new firmware fixing this security 
issue
in the very near future now it's been highlighted?  If so, I could
persuade myself to hang on to it for a few weeks.

Thanks,

Nick

Response (Mark S.) - 04/15/2004 10:29 AM
Unfortunately the firmware has not been released to us from Conexant 
and
we regret your decision to return the modem...


Thank you

Customer (Nick Warne) - 04/14/2004 03:34 PM
Any news on this?  Otherwise I will have to return the product as 
'unfit
for use as advertised due to known security problems since Oct. 
2003'.

Regards,

Nick

Customer (Nick Warne) - 04/13/2004 02:17 PM
OK, I can get around some of this.

1.  I have found the telnet session on port 23 only accepts one 
session -
so by running a (non-connected) telnet backgound job from a LAN box 
to the
router then forces the router to refuse any other connections on that
port.  That is a hacked fix, not perfect but it does the job.

2.  Although following the instructions to set a password on the 
telnet
session connected via port 254, this is not 'saved' at all.  It is 
only
current until router is rebooted.  It still leaves the port open for 
all
to connect.  Note!  that this password is for another users, and NOT
administrator - there is nowhere with the web config to set this 
user,
mysteriously?

Another question.  Looking at other DSL modem/routers I have found a
similar model but with a slightly different config.reg - which 
includes
telnet denial.

NOTE that the following OEM and OEM firmware versions are the same 
from
the different Manufactores (i.e. Zoom and A.N.Other)!!

The relevant Zoom config.reg:

================================================
[Class\Service\System]
"Manufacturer"="Conexant Systems, Inc."
"Model"="Trident"
"OemFirmwareVersion"="0.0.1"
"LoginUserPassword"="xxx"
"LoginAdminPassword"="xxxx"
"FtpServerEnabled"=dword:00000001
"WanFtpDisabled"=dword:00000001
"TftpServerEnabled"=dword:00000000
"MultiUserEnabled"=dword:00000001
"AdslRefreshRate"=dword:00000002
"UpdateHost"="10.0.0.2"
"UpdateUser"="anonymous"
"UpdatePassword"="password"
"UpdatePath"=""
"UpdateFile"="firmware.dlf"
"UpdateBootRomFile"="bootrom.dlf"
================================================

And the relevant 'A.N.Other' config.reg - Please note the 
telnet/terminal
disable lines:

================================================
[Class\Service\System]
"Manufacturer"="Conexant Systems, Inc."
"Model"="Trident"
"OemFirmwareVersion"="0.0.1"
"Vid"=dword:00000000
"LoginUserPassword"="xxx"
"LoginAdminPassword"="xxxx"
"FtpServerEnabled"=dword:00000001
"WanFtpDisabled"=dword:00000000
"TftpServerEnabled"=dword:00000000
"WanCliTelnetDisabled"=dword:00000001
"DumbTerminalTelnetEnabled"=dword:00000000
"WanDumbTerminalTelnetDisabled"=dword:00000001
"SmartTerminalEnabled"=dword:00000000
"WanSmartTerminalDisabled"=dword:00000001
================================================

Can you advise please if I can add these options to the Zoom 
config.reg to
turn off the open telnet/terminal services.

Thanks,

Nick

Customer (Nick Warne) - 04/13/2004 11:30 AM
This does not resolve my problem, as I have 5 'real' IP's and 
therefore do
not use the NAT option on the router - therefore I have no ports to
forward.  This is an issue with using no-NAT.

Also my router/modem is running Zoom 2.41 firmware.  I do not have at
option in the HTML server page to block port 23 - just port 80.

I really need a firmware upgrade from Zoom.

Regards,

Nick

Response (Mark S.) - 04/13/2004 11:12 AM
We have seen that in the current shipping 2.41, 2.42 and 2.43 code 
ports
 23, 80, 254, 255  are all displayed as "Open" by the scanning S/W. 
 To fix this in 2.41, 2.42 and 2.43 there are two entries in the 
Virtual
 Server portion of the modem's HTML config pages. These entries, for 
ports
 23 and 80,  point these ports to a non-existent LAN IP address
 (10.0.0.254).If a port is scanned then this scan packet is then 
passed by
 the modem to this non-existent IP address on the LAN. Therefore the 
scan
 device never receives a response and displays this port as "stealth" 
or
 filtered". In the Turkey 2.4.4 code two more Virtual Server entries 
were
 added for ports 254 and 255. 

 Adding Virtual Server entries is not a good solution but it works
 temporarily. We did report this to Conexant and in the latest code 
they
 have fixed the problem by making these ports "non responsive" as to 
be
 reported as stealth or filtered. No Virtual Server entries are 
needed.

Customer (Nick Warne) - 04/13/2004 06:13 AM
Please refer to this:

http://www.chiark.greenend.org.uk/~theom/security/origo.html

I have set a password on the telnet session on port 254 as per the 
above
instructions.

This is a serious issue, and needs to be fixed.  I am seriously 
thinking
about returning this modem now due to this.

Nick
==============================================

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

