Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTJJVRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJJVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:17:37 -0400
Received: from jdavies.dsl.xmission.com ([166.70.25.250]:13096 "EHLO
	smtp.millcreeksys.com") by vger.kernel.org with ESMTP
	id S263176AbTJJVRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:17:35 -0400
Message-ID: <1065820650.3f8721ea4162b@secure.millcreeksys.com>
Date: Fri, 10 Oct 2003 15:17:30 -0600
From: Uncle Jens <kernel@millcreeksys.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 64.50.56.162
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about some type of kernel-based-DRM, where only properly(trusted) signed
binaries can be executed?  For example, I could compile my public key in with
the kernel and it would only run binaries that had been signed by my private
key.  I feel that this would be a great security enhancement and would like to
hear about any issues this may present.
I've searched all over for a project that does something like this and have been
unable to find one.  I'd like to start one up on my own, but lack the kernel
development expertise.

I'm open for any input/flames/etc....


Michael



Quoting "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>:

> 2.7 "thoughts"
> Thanks to Gabor, Stuart, Stephan and others
> Don't hesitate to send me more or comment.
> 
> Regards,
> Fabian
> 
> * slab allocation quota
> * ntfs full support
> * kernel web server (Interfaced to Roman config tool)
> * ipc to sysfs
> * complete user quota centralization
> * Add _responsibilities_ for virtual process tree and possible
> relation in oops cases
> * Does the whole proc vm stuff root/box relevant ?I don't think
> so....Hence, those proc entries deserve security relevant attributes
> * Devices should be limited as well against bad usage(floppy defect),
> viral activity(netcard rush)...
> * Improve kobject model for security, quota rendering
> * bind mount support for all general mount options (nodev,ro,noexec etc)
>   with SECURE implementation with any (maybe even future) filesystems?
> * union mount (possible with option to declare on what fs a new file
>   should be created: on fixed ones, random algorithm, on fs with the
>   largest free space available etc ...)
> * guaranteed i/o bandwidth allocation?
> * netfilter's ability to do tricks which OpenBSD can do now with its
>   packet filter
> * ENBD support in official kernel with enterprise-class 'through the
>   network' volume management
> * Standard kernel output (Minimum, Full options ...)
> * Virtual machine support
> * /proc interface alternative to modutils/module-init-tools.
>                 That is, to have a directory of virtual nodes in /proc
>                 to provide the functionality of insmod, rmmod, lsmod &
>                 modprobe would be great -- especially from the viewpoint
>                 of recue disk images, etc.
> * Software RAID 0+1 perhaps?
>                 A lot of hardware RAID cards support it, why not the
>                 kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
>                 stripe-RAID arrays.  (Or can this be done already?)
> * Transparent Software-RAID for IDE RAID cards...
>                 This could be done by using the Software RAID
>                 functionality of the kernel, but making the RAID
>                 interface transparent, so you only see a /dev/md?
>                 device, rather than multiple /dev/?da* entries.
> * hotplug RAM
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


