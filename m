Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278402AbRJXOFo>; Wed, 24 Oct 2001 10:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRJXOFZ>; Wed, 24 Oct 2001 10:05:25 -0400
Received: from h195s128a249n47.user.nortelnetworks.com ([47.249.128.195]:4526
	"EHLO zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S278402AbRJXOFN>; Wed, 24 Oct 2001 10:05:13 -0400
Message-ID: <3BD6CA13.613B22EE@nortelnetworks.com>
Date: Wed, 24 Oct 2001 10:02:59 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
Cc: Julian Anastasov <ja@ssi.bg>, Tim Hockin <thockin@sun.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli> <3BD65188.1060203@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Actually it is quite sane.  The tool is not.
> 
> Switch to 'ip' instead of 'ifconfig', several large distros now include
> it.  Addresses can be added and removed completely indiscriminately on
> interfaces.
> 
> The "ethN:X" is a legacy design that is now deprecated.

Minor issue...if I create (using 'ip') two addresses on the same subnet on the
same device, one of them is primary and the other is secondary.  If I then
delete the primary address, the second one goes with it.

I submit that this is bad behaviour.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
