Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbRFSPJt>; Tue, 19 Jun 2001 11:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFSPJj>; Tue, 19 Jun 2001 11:09:39 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:55254
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S264274AbRFSPJb>; Tue, 19 Jun 2001 11:09:31 -0400
Message-ID: <3B2F6ADA.C2AD0304@nortelnetworks.com>
Date: Tue, 19 Jun 2001 11:08:10 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to display proxy arp addresses using "ip neigh" from iproute2
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru> <3B2A538A.BA62148A@linuxjedi.org> <3B2F5282.30602@niisi.msk.ru> <3B2F5BEC.A94F33A3@linuxjedi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a small question.  I have an explicit proxy arp address added to the arp
cache using the command "ip neigh add proxy 47.129.82.116 dev eth1"

Using the old-style "arp -n" command I get the following output:

Address           HWtype  HWaddress           Flags Mask    Iface
47.129.82.1       ether   00:E0:16:6C:79:42   C             eth0
47.129.82.95      ether   00:20:78:07:E6:A0   C             eth0
47.129.82.116     *       *                   MP            eth0

However, if I use the new-style command "ip neigh show" I get: 

47.129.82.1 dev eth0 lladdr 00:e0:16:6c:79:42 nud reachable
47.129.82.95 dev eth0 lladdr 00:20:78:07:e6:a0 nud delay

How can I see what I've got set for proxy arps using the "ip neigh" command?

Help!

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
