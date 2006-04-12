Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWDLIQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWDLIQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDLIQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:16:16 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:13009 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932096AbWDLIQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:16:16 -0400
Date: Wed, 12 Apr 2006 10:16:13 +0200
From: David Weinehall <tao@acc.umu.se>
To: Pramod Srinivasan <pramods@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <20060412081613.GX23222@vasa.acc.umu.se>
Mail-Followup-To: Pramod Srinivasan <pramods@gmail.com>,
	linux-kernel@vger.kernel.org
References: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 12:01:02AM -0700, Pramod Srinivasan wrote:
> > 3. Userspace code that uses interfaces that was not exposed to userspace
> > before you change the kernel --> GPL (but don't do it; there's almost
> > always a reason why an interface is not exported to userspace)
> 
> > 4. Userspace code that only uses existing interfaces --> choose
> > license yourself (but of course, GPL would be nice...)
> 
> > 5. Userspace code that depends on interfaces you added to the kernel
> > --> consult a lawyer (if this interface is something completely new,
> > you can *probably* use your own license for the userland part; if the
> > interface is more or less a wrapper of existing functionality, GPL)
> 
> An example could be helpful in clarifying the GPL license.
> 
> Suppose I use the linux-vrf patch for the kernel that is freely
> available and use the extended setsocket options such as SO_VRF in an
> application, do I have to release my application under GPL since I am
> using a facility in the kernel that a standard linux kernel does not
> provide?
> 
> Suppose my LKM driver adds a extra header to all outgoing packets and
> removes the extra header from the incoming packets, should this driver
> be released under GPL.? In a way it extends the functionality of
> linux, if I do release the driver code under GPL because this was
> built with linux  in mind, Should I release the application  which
> adds intelligence to interpret the extra header under GPL?

As I said above, you need to consult a lawyer in unclear cases.
The examples you list above seems innocent enough, but again, I am not a
lawyer.  A lot has to do with intent.  Are you exporting things to
userland just to workaround the GPL?  If so, you're likely violating
the GPL... =)


Regards: david
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
