Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUFMGL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUFMGL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 02:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUFMGL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 02:11:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:1042 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265008AbUFMGLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 02:11:55 -0400
Date: Sun, 13 Jun 2004 08:19:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040613061957.GA3012@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net> <20040608210846.GA5216@mars.ravnborg.org> <20040609142141.GT20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609142141.GT20632@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 04:21:41PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2004-06-08 23:08:46 +0200, Sam Ravnborg <sam@ravnborg.org>
> wrote in message <20040608210846.GA5216@mars.ravnborg.org>:
> > On Mon, Jun 07, 2004 at 04:13:53PM +0200, Wichert Akkerman wrote:
> > I'm in progress of doing some infrastructure work to better support building
> > different packages. I have requests for .tar.gz, tar.gz2 as well
> > as deb.
> 
> (Being a Debian user...) I really *love* to see a .tar.{gz,bz2} target.
> For my in-house use (as well in in the company I work for) we do have a
> script to basically install modules (+ vmlinuz + vmlinux + .config +
> System.map), adding some identifier to the filenames (of the last four
> files mentioned) and preparing a .tar.gz from that.

Could you try to be more specific in what you expect to see in a .tar.gz'ed kernel.
A script that creates a .tar.gz from current kernel would be fine :-)


I expect something like:
All files stored in a directory named: kernel-2.6.6-rc4/
Includes all source files
Includes .config

Do you expect to see a fully build kernel?
- With all .o files
- With the output file (bzImage or whatever used by selected architecture)

Anything else?

	Sam
