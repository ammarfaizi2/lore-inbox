Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRIRQii>; Tue, 18 Sep 2001 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRIRQiS>; Tue, 18 Sep 2001 12:38:18 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:40350
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272493AbRIRQiP>; Tue, 18 Sep 2001 12:38:15 -0400
Message-ID: <3BA7786F.E07E41F2@nortelnetworks.com>
Date: Tue, 18 Sep 2001 12:38:07 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to display manually set proxy ARP entries with iproute2?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This issue was posted on the netdev list a while back and got no answer.

I'm quoting the original post here:

Lutz Pressler wrote:
> 
> Hello,
> 
> I am not able to get information about manually set proxy ARP entries
> with the "ip" tool (iproute2-ss010824), tested on both 2.2.19 and
> 2.4.8-ac7 kernels.
> 
> # ip neigh add proxy 172.20.1.1 dev eth0
> 
> The "arp" tool then yields (normal entries trimmed)
> # arp -n
> Address              HWtype  HWaddress           Flags Mask        Iface
> 192.168.1.254        ether   00:80:C8:F6:47:6F   C                 eth0
> 172.20.1.1           *       *                   MP                eth0
> 
> but "ip" only shows
> # ip neigh show
> 192.168.1.254 dev eth0 lladdr 00:80:c8:f6:47:6f nud reachable
> 
> Is this expected behaviour or a (kernel) bug?

I'd like to know about this as well, since this is the only reason why I keep
the "arp" command around.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
