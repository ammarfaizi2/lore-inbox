Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271383AbTHHOhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271384AbTHHOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:37:55 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:34703 "HELO
	develer.com") by vger.kernel.org with SMTP id S271383AbTHHOhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:37:53 -0400
Message-ID: <3F33B5B5.6050705@develer.com>
Date: Fri, 08 Aug 2003 16:37:41 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Nicolas Pitre <nico@cam.org>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
References: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>	 <200307290102.01313.bernie@develer.com> <1060349104.25209.364.camel@passion.cambridge.redhat.com>
In-Reply-To: <1060349104.25209.364.camel@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Tue, 2003-07-29 at 00:02, Bernardo Innocenti wrote:
> 
>>I've read in the Kconfig help that JFFS2 still depends on mtdblock even
>>though it doesn't use it for I/O. I think I've also seen some promise
>>that this dependency will eventually be removed...
> 
> It's already been removed from everything but the Kconfig file... :)

So, let's try to remove the block layer from the kernel.
Do you reckon it would be difficult to do?

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



