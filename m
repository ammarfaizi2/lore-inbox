Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTIBIjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIBIjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:39:14 -0400
Received: from [202.54.64.126] ([202.54.64.126]:56787 "EHLO
	turaco.siptech.co.in") by vger.kernel.org with ESMTP
	id S263648AbTIBIjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:39:07 -0400
Message-ID: <3F545A5C.2070502@siptech.co.in>
Date: Tue, 02 Sep 2003 14:22:44 +0530
From: Elanjchezhiyan <chezhiyan@siptech.co.in>
Organization: SIP Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ethtool setting is not changed in the Linux redhat 8.0?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: SIP - Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

My system is Linux red hat 8.0. I have installed Ethtool1.8. And I made 
change in SIOCETHTOOL for
#define SIOCETHTOOL 0x8947 --This will give output for all the argument 
except -i
//#define SIOCETHTOOL 0x8946 ---This will give details about -i argument 
only.

See the exection below:
for listing:
[root sip7 <mailto:root%20sip7> ethtool-1.8]# ./ethtool -a eth0
Pause parameters for eth0:
Autonegotiate: off
RX: off
TX: off
[root sip7 <mailto:root%20sip7> ethtool-1.8]# ./ethtool -A eth0 rx on   
// The rx is changed


[root sip7 <mailto:root%20sip7> ethtool-1.8]# ./ethtool -a eth0
Pause parameters for eth0:
Autonegotiate: off
RX: off                      // rx not refelected
TX: off


[root sip7 <mailto:root%20sip7> ethtool-1.8]# ./ethtool -A eth0 rx off
rx unmodified, ignoring
no pause parameters changed, aborting

This Urgent!!!!!!!!!!!!!!!!
Any body help you out ?????????????????

current ethernet dev Details:-
eth0 Link encap:Ethernet HWaddr 00:80:C8:92:86:7E
inet addr:192.168.66.7 Bcast:192.168.66.255 Mask:255.255.255.0
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:13344 errors:0 dropped:0 overruns:0 frame:0
TX packets:9143 errors:4 dropped:0 overruns:0 carrier:6
collisions:0 txqueuelen:100
RX bytes:5695058 (5.4 Mb) TX bytes:1323452 (1.2 Mb)
Interrupt:12 Base address:0xa000
Thank in Advanced,
Regards,
Elan

-- 
T.Elanjchezhiyan
Core Technology Group
 
SIP Technologies & Exports Ltd
G4, Elnet Software City,CPT Road
Taramani, Chennai 600 113
India
Phone: +91-44-22541401
           +91-44-22541031
Fax    : +91-44-22541475
Website: http://www.siptech.com
-----------------------------------------
  


-- 
T.Elanjchezhiyan
Core Technology Group
 
SIP Technologies & Exports Ltd
G4, Elnet Software City,CPT Road
Taramani, Chennai 600 113
India
Phone: +91-44-22541401
           +91-44-22541031
Fax    : +91-44-22541475
Website: http://www.siptech.com
-----------------------------------------
  



. 

