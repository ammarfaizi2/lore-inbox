Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270037AbUJHQxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270037AbUJHQxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270039AbUJHQxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:53:32 -0400
Received: from open.hands.com ([195.224.53.39]:48338 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S270037AbUJHQxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:53:20 -0400
Date: Fri, 8 Oct 2004 18:04:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008170426.GN5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net> <4166B1F3.4020102@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4166B1F3.4020102@didntduck.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 11:27:47AM -0400, Brian Gerst wrote:

> >>What are you trying to do?  
> >
> >
> > call sys_rename, sys_pread, sys_create, sys_mknod, sys_rmdir
> > etc. - everything that does file access.
> >
> 
> Why?  What are you trying to do that cannot be done in userspace?
 
 see other message: i'm trying to combine fuse + its example program
 fusexmp into a kernelspace module: when i added xattrs i get a -512
 pleasetrylater response which selinux cannot cope with.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

