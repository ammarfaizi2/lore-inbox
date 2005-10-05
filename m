Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVJEWs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVJEWs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVJEWs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:48:58 -0400
Received: from free.hands.com ([83.142.228.128]:26295 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1030411AbVJEWs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:48:57 -0400
Date: Wed, 5 Oct 2005 23:48:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Marc Perkel <marc@perkel.com>, Al Viro <viro@ftp.linux.org.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005224847.GN10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <Pine.LNX.4.63.0510051150570.3798@cuia.boston.redhat.com> <4343F815.4000208@perkel.com> <20051005161527.GU7992@ftp.linux.org.uk> <4343FE1C.7090700@perkel.com> <20051005193024.GG8011@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005193024.GG8011@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 03:30:24PM -0400, Lennart Sorensen wrote:
> On Wed, Oct 05, 2005 at 09:23:56AM -0700, Marc Perkel wrote:
> > That's not the point. The point is that Netware has a far superior 
> > permission system and I am suggesting the the Linux community learn from 
> > it and take advantage of seeing what better looks like and improving itself.
> 
> Linux is compatible with unix applications.  Netware is not.  Supporting
> some useless netware feature at the expense of posix/unix compatibility
> would be insane.
> 
> If you can't do it with unix permissions or unix permissions + ACL, you
> don't need to do it at all most likely, and even more likely you

 the bastion sftp example i gave which required selinux on top of a much
 broader set of POSIX file permissions demonstrates the fallacy of your
 statement.

 try to achieve the same effect with POSIX - even POSIX ACLs
 (uploader only has create and write, not read, not delete;
  downloader has read and delete, not write, not create)

 and you will fail, miserably, because under POSIX, write implies
 create.

 l.

