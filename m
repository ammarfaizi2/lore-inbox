Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275256AbRJAQcl>; Mon, 1 Oct 2001 12:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275255AbRJAQcb>; Mon, 1 Oct 2001 12:32:31 -0400
Received: from [172.16.44.254] ([172.16.44.254]:50959 "EHLO
	int-mx1.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275254AbRJAQc1>; Mon, 1 Oct 2001 12:32:27 -0400
Date: Mon, 1 Oct 2001 11:32:59 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: Anthony <aslan@ispdr.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch files
Message-Id: <20011001113259.7f61ab7f.reynolds@redhat.com>
In-Reply-To: <4.3.2.7.2.20011002021641.02340710@mail.ispdr.net.au>
In-Reply-To: <4.3.2.7.2.20011002021641.02340710@mail.ispdr.net.au>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.2cvs8 (GTK+ 1.2.9; )
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony <aslan@ispdr.net.au> was pleased to say:

> Hi everyone,
> 	I'm new to this list, and have been using Linux for just over a year now. 
> I'll get straight to the point, as I think this may be a bit off-topic. I'm 
> trying to apply a patch file to support a PCI printer card I've got. The 
> patch file contains several patches, but only the last one is working. I'm 
> prepared to try and sort it out myself, but I just need to know something 
> about the patch file so I might be able to understand how it works. Can 
> anyone please explain (or point me to the relevant documentation) to me 
> what the following lines mean?:
> 
> --- linux/include/linux/pci_ids.h.netmos	Sat Sep  8 09:44:43 2001
> +++ linux/include/linux/pci_ids.h	Sat Sep  8 09:44:45 2001
> @@ -1664,8 +1664,12 @@
> 
> And this is from further down in the patch:
> @@ -2831,6 +2839,15 @@
> 
> I'm using RedHat 7.1 with the included 2.4.2-2 kernel. Any help on this 
> matter would be much appreciated.

Larry Wall's patch program uses the diff(1) program to perform the file
comparisons, so an "info diff" command is your friend.  Hint: this is a context
diff.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto:	<reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.236.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923
