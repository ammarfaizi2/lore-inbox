Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUDQUW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDQUW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:22:27 -0400
Received: from florence.buici.com ([206.124.142.26]:6272 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264040AbUDQUWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:22:25 -0400
Date: Sat, 17 Apr 2004 13:22:23 -0700
From: Marc Singer <elf@buici.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040417202223.GA8434@flea>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <A7E7103A-90A1-11D8-833E-000A958E35DC@fhm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7E7103A-90A1-11D8-833E-000A958E35DC@fhm.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 09:01:38PM +0200, Daniel Egger wrote:
> On 17.04.2004, at 20:32, Marc Singer wrote:
> 
> >I'd be glad to compare TCP to UDP on my system.  It's using an nfsroot
> >mount.  It looks like the support is there.  What activates it?
> 
> You need to add at least tcp as parameter to the nfsroot boot option,
> like nfsroot=1.1.1.1:/tftpboot/foo,tcp,v3 .

What I'd like to do is use a command line like this

  root=/dev/nfs ip=rarp nfsroot=,tcp,v3

But, it doesn't work.  I'd like to let the kernel autoconfiguration
handle the addressing.

> And, of course, if you mount/remount NFS partitions you also need to
> specify the tcp parameter in your fstab.
> 
> Servus,
>       Daniel


