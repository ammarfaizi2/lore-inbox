Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290803AbSAaBS2>; Wed, 30 Jan 2002 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290798AbSAaBSK>; Wed, 30 Jan 2002 20:18:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44257 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290803AbSAaBR4>;
	Wed, 30 Jan 2002 20:17:56 -0500
Date: Wed, 30 Jan 2002 20:17:54 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>, raul@viadomus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020130201754.B18730@havoc.gtf.org>
In-Reply-To: <200201301824.g0UIOMO32639@devserv.devel.redhat.com> <5960.1012433626@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5960.1012433626@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 10:33:46AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 10:33:46AM +1100, Keith Owens wrote:
> On Wed, 30 Jan 2002 13:24:22 -0500, 
> Pete Zaitcev <zaitcev@redhat.com> wrote:
> >Kernel headers are not to be included in applications.
> 
> Just to flog this dead horse into the ground, the reverse is also true.
> Kernel code must not include user space headers (kernel code excludes
> programs that are used to build the kernel).

Wow, does that actually occur?  File references?

	Jeff



