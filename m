Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVCDA1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVCDA1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVCDAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:07:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53923 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262760AbVCCXkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:40:36 -0500
Date: Thu, 3 Mar 2005 18:39:27 -0500
From: Bill Nottingham <notting@redhat.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, davem@davemloft.net,
       jgarzik@pobox.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303233927.GA15850@nostromo.devel.redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
	davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org> <20050303012707.GK10124@redhat.com> <20050303145846.GA5586@pclin040.win.tue.nl> <20050303130901.655cb9c4.akpm@osdl.org> <20050303212115.GJ29371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303212115.GJ29371@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (davej@redhat.com) said: 
>  > [*] I don't know any details of the /proc incompatibility which davej
>  >     mentions, and I'd like to.  That sounds like a screw-up.
> 
> We changed the format of /proc/slabinfo.  Running slabtop threw up
> an error message complaining that the format had changed.
> 
> It was a graceful failure, but a failure none-the-less.
> 
> Other failures have been somewhat more dramatic.
> I know ipsec-tools, and alsa-lib have both caused pain
> on at least one occasion after the last 2-3 kernel updates.

The ones I remember were:

- alsa-lib, as mentioned
- ipsec-tools/openswan needed updating when the kernel changed
   to require forward SAs
- a old script on an earlier release needed fixed when usbdevfs finally
   went from being deprecated to dead

SELinux changed froom 2.6.early to 2.6.current as well, IIRC.

Bill
