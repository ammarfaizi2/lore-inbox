Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJINvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJINvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:51:15 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:48010 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262174AbTJINui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:50:38 -0400
Date: Thu, 9 Oct 2003 15:50:36 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 thoughts
Message-ID: <20031009135036.GJ8370@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <D9B4591FDBACD411B01E00508BB33C1B01F248F8@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F248F8@mesadm.epl.prov-liege.be>
X-Operating-System: vega Linux 2.6.0-test5 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 03:17:05PM +0200, Frederick, Fabian wrote:
> * bind mount support for all general mount options (nodev,ro,noexec etc)
>   with SECURE implementation with any (maybe even future) filesystems?
> 
> * union mount (possible with option to declare on what fs a new file
>   should be created: on fixed ones, random algorithm, on fs with the
>   largest free space available etc ...)
> <LVM ?

Dunno about LVM, I've not plaied a lot with it ...

> 
> * guaranteed i/o bandwidth allocation?
> * netfilter's ability to do tricks which OpenBSD can do now with its
>   packet filter
> 
> * ENBD support in official kernel with enterprise-class 'through the
>   network' volume management
> < NFS ?

NFS is a filesystem. However I meant filesystem independent access, ie
raw device access through the network and creating any filesystem on it.
NBD can do this, ENBD is even better, but I think it can be further developed
sure, and at least AFAIK ENBD is not inside the official kernel. Or maybe
it is? :)

> * more and more tunable kernel parameters to be able to have some user
>   space program which can 'tune' the system for the current load,usage,etc
>   of the server ("selftune")
> <What parameters would you add in procfs ?

In general :) Maybe this is not the question of the kernel nowdays, but that
userspace program. I mean now we can hear news about chaning scheduler
behaviour on-the-fly and other interesing stuffs. I meant these class of
parameters for example. Like the case of the OOM killer and others I know
that implementing a quite complex algorithm inside the kernel is not a good
point, probably. That's why I thought that this kind of on-line "selftuning"
can be possible with a user space process, the only need is to provide
enough statistical parameters and tuning possibilites by the kernel, so the
tuner can do its job. However I don't know that this theory is useful for
reality it was only a wild idea (but sounds good IMHO :)

> * Virtual machine support
> <Maybe more 3.0 relevant ?

:)

-- 
- Gábor (larta'H)
