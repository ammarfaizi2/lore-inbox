Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276126AbRI1P22>; Fri, 28 Sep 2001 11:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276123AbRI1P2T>; Fri, 28 Sep 2001 11:28:19 -0400
Received: from [172.16.44.254] ([172.16.44.254]:47366 "EHLO
	int-mx1.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276119AbRI1P2L>; Fri, 28 Sep 2001 11:28:11 -0400
Date: Fri, 28 Sep 2001 10:28:36 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: Norbert Roos <n.roos@berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inverse mmap() available?
Message-Id: <20010928102836.02d0450a.reynolds@redhat.com>
In-Reply-To: <3BB49438.1F2C59B3@berlin.de>
In-Reply-To: <3BB49438.1F2C59B3@berlin.de>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.2cvs5 (GTK+ 1.2.9; )
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Roos <n.roos@berlin.de> was pleased to say:

> 
> Hello!
> 
> Is there a way to map user space memory into kernel address space, e.g.
> that i don't have to call get_user(var,...) but simply use var =
> *user_space_ptr?
> 
> What i intend to do (as the next step) is to DMA-transfer data directly
> between a PCI device and user space memory. The buffer in user space
> should be allocated with malloc(), so allocating a buffer in kernel and
> mmap()-ping it to user space is not the solution..
> 
> I guess this has been asked before, any links to further information
> would be great.

Look at the KIOBUF stuff in <linux/iobuf.h> for how to do this.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto:	<reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.236.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923
