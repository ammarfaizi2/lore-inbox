Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbUK3RKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUK3RKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUK3RJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:09:27 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:42933 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S262217AbUK3RGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:06:47 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Message-Id: <1101834194.17826.194.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Nov 2004 17:03:14 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 16:31, Horst von Brand wrote:
> > But namespace unification is important,
> 
> Why? Directories are directories, files are files, file contents is file
> contents. Mixing them up is a bad idea.

I disagree, I think it is a good idea.
Why is namespace unification important? Because you can use the same
tools on everything. Previously, each tool could handle one namespace.

A very simple example would be:
I want to count the words in the Appendix of my book.
If I can't select the appendix, my "wc" tool is useless (or very
difficult to use). On the other hand if I can say

wc ~/book/Appendix

it's fine. Hans Reiser would say that "namespaces are the roads and
waterways of the operating system" and "the value of an operating system
is proportional to the number of connections you can make". I think he
is right in that. And the authors of Unix knew it too, when they used
the same namespace for devices and files. They didn't say "files are
files and devices are devices". They said the difference should not
matter to the applications.
But there is still namespace fragmentation even in Unix, and this is
just one of them.

>  Sure, you could build a filesystem
> of sorts (perhaps more in the vein of persistent programming, or even data
> base systems) where there simply is no distinction (because there are no
> differences to show), but that is something different.
> 
> >                                         and to unify the namespace, you
> > have to use the same syntax. I guess you disagree with me on that. (If
> > not, how would you do it?)
> 
> I'd go one level up: Eliminate the distinctions that bother you, not try to
> patch over them.

But that is my point too. Peter

