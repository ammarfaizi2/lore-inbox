Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbSKOT2d>; Fri, 15 Nov 2002 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSKOT2d>; Fri, 15 Nov 2002 14:28:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:26866 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266631AbSKOT2c>; Fri, 15 Nov 2002 14:28:32 -0500
Date: Fri, 15 Nov 2002 12:28:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Khoa Huynh <khoa@us.ibm.com>, kniht@us.ibm.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mailing-lists@digitaleric.net, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <326030000.1037392121@flay>
In-Reply-To: <OFF50CC956.56290AFD-ON85256C72.005E479D@pok.ibm.com>
References: <OFF50CC956.56290AFD-ON85256C72.005E479D@pok.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A way to get around this is to create 3-level component list (as opposed
> to 2-level currently: category and components).  This 3-level component
> list would go like this:
> 
> Product --> Category --> Component

I'm not sure we really want this to be 3-level as that'd involve 
replicating all the categories underneath. The OpSys field type 
suggestion as an independant field would be nice, but the Bugzilla 
code will need some tweaking to support possibly different default
owners dependant on that field.

For now, Jon has created us an "Alternate trees" category, with "ac" 
and "mm" components, with appropriate text in the template to encourage
people to file bugs that happen (only) on those trees under the 
"tree-specific" categories, and we can move bugs out from there if 
need be. Hopefully that will make people happier for now, there may
be a cleaner solution long-term, but that needs more thought and more
work.

M.

