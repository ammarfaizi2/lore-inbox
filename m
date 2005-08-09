Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVHIP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVHIP4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVHIP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:56:47 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:33666 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S964835AbVHIP4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:56:46 -0400
Message-ID: <42F8D23D.3000505@vc.cvut.cz>
Date: Tue, 09 Aug 2005 17:56:45 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops in VMWARE vmnet, on 2.6.12.x
References: <200508091744.33523@gj-laptop>
In-Reply-To: <200508091744.33523@gj-laptop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Piotr Jaskiewicz wrote:
> I know that in general no one here is interested in vmware affairs, but in 
> hope that VMware folks are reading this list too, here's the oops:
> It's the newest vmware5 for linux from vmware.com

You must update vmnet with vmware-any-any-update93 patch
(http://platan.vc.cvut.cz/ftp/pub/vmware).  sk_alloc() function
changed type of its arguments, and unfortunately this causes only
compile-time warning, which you did not notice, but resulting module crashes
kernel as now mandatory argument is passed in as '0'.

You should report problems related to the VMware at the VMware community forums,
http://www.vmware.com/community/index.jspa.  Most of peoples on LKML does not
care about these opensource modules.
								Petr Vandrovec


