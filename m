Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266907AbUBEV6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266915AbUBEV6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:58:19 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:61899 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266907AbUBEV6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:58:10 -0500
Message-ID: <4022BC22.9000803@nortelnetworks.com>
Date: Thu, 05 Feb 2004 16:56:50 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: "Tillier, Fabian" <ftillier@infiniconsys.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, sean.hefty@intel.com,
       linux-kernel@vger.kernel.org, hozer@hozed.org, woody@co.intel.com,
       bill.magro@intel.com, woody@jf.intel.com,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com> <20040205212703.GA15718@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Basically, what is lacking in the current kernel locks that the
> infiniband project has to have in order to work properly.  We can work
> from there.

I think their point is that they want the core device driver code to be 
portable across kernel versions, and across different OS's other than 
linux--which basically requires some kind of abstraction layer.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

