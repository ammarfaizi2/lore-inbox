Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268684AbUHTTZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268684AbUHTTZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUHTTZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:25:41 -0400
Received: from herkules.viasys.com ([194.100.28.129]:10941 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S268662AbUHTTZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:25:24 -0400
Date: Fri, 20 Aug 2004 22:25:18 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820192518.GK23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820114518.49a65b69.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 11:45:18AM -0700, you [Andrew Morton] wrote:
> > 
> >  Ok, 2.6.8.1-mm2 minus dev-mem-restriction-patch.patch fixes the "cannot
> >  allocate memory" problem. 
> 
> Thanks for working that out.

No problem. (If only compile-reboot-startx-launch vmware was faster on my
computer...)
 
> >   vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
> >   vmmon: I'll try accessing page tables directly, but you should know that your
> >   vmmon: kernel is br0ken and you should uninstall all additional patches you vmmon: have installed!
> >   vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)
> > 
> >  I'm still not 100% which of the patches causes that get_user_pages()
> >  warning.
> 
> If you could work that out sometime, it would help.

I'll try to do that as soon as I find time.



-- v -- 

v@iki.fi

