Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTLCXdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTLCXcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:32:47 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:10180 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S262687AbTLCXce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:32:34 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: root@chaos.analogic.com
Date: Wed, 03 Dec 2003 15:33:47 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <3FCE025B.23398.3EBE7C18@localhost>
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
In-reply-to: <Pine.LNX.4.53.0312031648390.3725@chaos>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> > So does this exception clause exist or not? If not, how can the binary
> > modules be valid for use under Linux if the source is not made available
> > under the terms of the GNU GPL?
> 
> I'll jump into this fray first stating that it is really great that
> the CEO of a company that is producing high-performance graphics
> cards and acceleration software is interested in finding out this
> information. It seems that some other companies just hack together
> some general-purpose source-code under GPL and then link it with a
> secret object file. 

Well one of the primary reasons we are interested in researching this is 
because we are in the process of preparing to release the SciTech SNAP 
DDK under the GNU GPL license (dual licensed for proprietry developers), 
and want to understand the ramifications of this approach. I must say I 
am surprised to see that such a clause does not exist, since binary only 
modules seem to be pretty abundant in the community.

Then again the whole 'derived works' clause in the GPL is a huge gray 
area IMHO, and even just sitting there arguing with myself I can come up 
with pretty good arguments in both directions for why a binary only 
module is legal or not. Especially when the only reference to this in the 
GNU GPL FAQ is about plugins, and they use a really silly distinction 
about whether a plugin uses fork/exec or not. I mean if you use fork/exec 
to start the plugin, yet the plugin uses RPC and shared memory to 
communicate with the main process, that is the same as local procedure 
calls and local memory IMHO.

> > Lastly I noticed that the few source code modules I looked at to see if
> > the exception clause was mentioned there, did not contain the usual GNU
> > GPL preable section at the top of each file. IMHO all files need to have
> > such a notice attached, or they are not under the GNU GPL (just being in
> > a ZIP/tar achive with a COPYING file does not place a file under the GNU
> > GPL). Given all the current legal stuff going on with SCO, I figured
> > every file would have such a header. In fact some of the files I looked
> > at didn't even contain a basic copyright notice!!
> 
> I have been told by lawyers who do intellectual property law for a
> living that under US Copyright law, the INSTANT that something is
> written anywhere in a manner that allows it to be read back, it is
> protected by the writer's default copyright protection. 

Yes of course, but if there is no notice in the file, who is the 
copyright holder? Only the original author knows for sure, and for 
someone to *use* that file without permission from the original author 
would be inviting a lawsuit.

> The writer may alter that protection or even assign ownership to
> something or somebody else, but nobody needs to  put a copyright
> notice anywhere in text. Now, if you intend to sue, before that
> suit starts, the text must be registered with the United States
> Copyright Office. In that case, it still doesn't need a copyright
> notice or the famous (c) specified by the act. It just needs to be
> identified by the writer, like: 
> 
> File:     TANGO.FOR        Created 12-DEC-1988     John R. Doe
> 
> Grin... from my VAX/VMS days.

Right, but there are files in the source code with *nothing* at the top. 
No copyright header, not notice of who wrote the file, nothing.

In my opinion, unless a specific source file has a copyright notice 
attached to it and specifically says 'you are licensed to use this file 
under the terms of the GNU GPL - see the COPYING file' etc, then that 
file is *not* under the GNU GPL. What that means is that I would have 
zero rights to use that file without direct permission from the author, 
and realistically should not use it. 

If there are lots of files like that in the Linux kernel, then that means 
that none of us really have the right to use Linux on our machines! 
Yikes. Considering that all GNU projects contain this type of header, I 
have always just assumed the Linux kernel source code would too. 
Especially now with this SCO debacle going on.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

