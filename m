Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUBFSYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUBFSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:24:31 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:64400 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265653AbUBFSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:23:57 -0500
Message-ID: <4023D964.4030509@nortelnetworks.com>
Date: Fri, 06 Feb 2004 13:13:56 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Roland Dreier <roland@topspin.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
 > On Fri, 6 Feb 2004, Roland Dreier wrote:

 >> This is totally, totally wrong.  If you get rid of do { } while
 >> (0), then you can't use the macro in an if statement.  Read any C
 >> FAQ for details, or try the following:
 >>
 >>
 >
 > Yes you can. You just don't use an ';' if you are going to use
 > 'else'.

That's just silly.  It means you need to know if something is a macro or
an inline function, and do stuff differently.  If you use the do/while
method, it Just Works.


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

