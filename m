Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSKFPyM>; Wed, 6 Nov 2002 10:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbSKFPyM>; Wed, 6 Nov 2002 10:54:12 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:55747 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265754AbSKFPyL>; Wed, 6 Nov 2002 10:54:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: Re: EVMS announcement
Date: Wed, 6 Nov 2002 09:21:16 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler> <m3iszblg0b.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3iszblg0b.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Message-Id: <02110609211601.06245@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 18:05, James H. Cloos Jr. wrote:
> >>>>> "Kevin" == Kevin Corry <corryk@us.ibm.com> writes:
> Kevin> In addition, this switch complicates having the root filesystem
> Kevin> on an EVMS volume.
>
> Actually, this isn't as much of an issue with 2.5-as-it-will-soon-be.
> The initramfs stuff solves the problem for booting, and is exactly
> where boot-time discovery should be.

Yep. This is what I was briefly trying to explain in the announcement. With 
initramfs stuff finally going into 2.5, root-on-complex-volume should become 
far less of an issue. For our users on 2.4, we will have to help them wade 
through initrd for the time being. My real hope is that initramfs will 
provide a much simpler method (compared to initrd) for adding new tools, 
scripts, etc to be run during early userspace. The info I've gathered about 
it so far seems to indicate this will be the case.

> You will need to ensure sufficient integration with hotplug to deal
> properly with such things as external devices (usb, 1394, cardbus/
> pcmcia, iscsi, docking stations, etc) and media bays.  But this should
> be relatively easy, yes?

Hopefully, yes. We will obviously want to take full advantage of hotplug, and 
any other device-level services that are available.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
