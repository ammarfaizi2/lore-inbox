Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTJINuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJINuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:50:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7396 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262164AbTJINu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:50:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>, lgb@lgb.hu
Subject: Re: 2.7 thoughts
Date: Thu, 9 Oct 2003 15:52:14 +0200
User-Agent: KMail/1.5.4
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F248F8@mesadm.epl.prov-liege.be>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F248F8@mesadm.epl.prov-liege.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310091552.14523.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this your TODO list?
You are very ambitious person.

;-)

--bartlomiej

On Thursday 09 of October 2003 15:17, Frederick, Fabian wrote:
> Gabor,
> 	Here's a first "2.7 thoughts" listing with some questions...
>
> 2.7 features
>
> *	slab allocation quota
> *	ntfs full support
> *	kernel web server (Interfaced to Roman config tool)
> *	ipc to sysfs
> *	complete user quota centralization
> *	Add _responsibilities_ for virtual process tree and possible
> relation in oops cases
> *	Does the whole proc vm stuff root/box relevant ?I don't think
> so....Hence, those proc entries deserve security relevant attributes
> *	Devices should be limited as well against bad usage(floppy defect),
> viral activity(netcard rush)...
> *	All this guides me to a more global conclusion in which all that
> stuff should be kobject registration relevant
> *	Meanwhile, we don't have a kobject <-> security bridge :(
>
> * bind mount support for all general mount options (nodev,ro,noexec etc)
>   with SECURE implementation with any (maybe even future) filesystems?
>
> * union mount (possible with option to declare on what fs a new file
>   should be created: on fixed ones, random algorithm, on fs with the
>   largest free space available etc ...)
> <LVM ?
>
> * guaranteed i/o bandwidth allocation?
> * netfilter's ability to do tricks which OpenBSD can do now with its
>   packet filter
>
> * ENBD support in official kernel with enterprise-class 'through the
>   network' volume management
> < NFS ?
>
> * more and more tunable kernel parameters to be able to have some user
>   space program which can 'tune' the system for the current load,usage,etc
>   of the server ("selftune")
> <What parameters would you add in procfs ?
>
> * more configuration options to be able to use Linux at the low end as well
>   (current kernels are too complex, too huge and sometimes contains too
>   many unwanted features for a simple system, though for most times it is
>   enough but can be even better)
>
> * Virtual machine support
> <Maybe more 3.0 relevant ?

