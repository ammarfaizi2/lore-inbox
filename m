Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUEISmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUEISmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 14:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUEISmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 14:42:16 -0400
Received: from ns.clanhk.org ([69.93.101.154]:50641 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264368AbUEISmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 14:42:12 -0400
Message-ID: <409E7B2C.6040206@clanhk.org>
Date: Sun, 09 May 2004 13:40:44 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: kangur@polcom.net, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
Subject: Re: Distributions vs kernel development
References: <200405090707.i49776Iv000342@81-2-122-30.bradfords.org.uk>	<20040509.105253.26927810.rene@rocklinux-consulting.de>	<Pine.LNX.4.58.0405091057060.14709@alpha.polcom.net> <20040509.111350.67880957.rene@rocklinux-consulting.de>
In-Reply-To: <20040509.111350.67880957.rene@rocklinux-consulting.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe wrote:

>Hi,
>
>On: Sun, 9 May 2004 10:59:48 +0200 (CEST),
>    Grzegorz Kulewski <kangur@polcom.net> wrote:
>
>  
>
>>You have binary packages in Gentoo so you can build once for many 
>>machines. All you need is to add one option to /etc/make.conf.
>>    
>>
>
>But the last time I took a look not even an installer or such.
>
When was the last time you looked?  You mean no GUI, braindead installer? 

> +
>Gentoo has no support for custom modifications not even thinking about
>a way to group such custom modifications / build configuration into a
>well defined way to form a distribution. 
>
Wow, have you ever used Gentoo actually?  Gentoo is a Meta-Distribution: 
a distribution that describes itself.  Purely by -definition- you can 
modify it in any way you want.  There is no limit to how you can modify 
it, I'm not sure what gives you this idea.

Custom groups?  Group is such a vague term, but I'll give an example of 
a "custom group."  Say you have an identical set of 50 mcahines each 
with their own harddrives.  You can maintain your own snapshop of Gentoo 
(ie portage) on your own rsync server in which you have your own sandbox 
in which you test and validate updates before pushing them to the 
"group" of 50 machines in a prebuilt binary package format.

Just read this snippet from the sample make.conf:

# FEATURES are settings that affect the functionality of portage. Most of
#     these settings are for developer use, but some are available to non-
#     developers as well.
#
#  'autoaddcvs'  causes portage to automatically try to add files to cvs
#                that will have to be added later. Done at generation times
#                and only has an effect when 'cvs' is also set.
#  'buildpkg'    causes binary packages to be created of all packages that
#                are merged.
#  'ccache'      enables ccache support via CC.
#  'cvs'         feature for developers that causes portage to enable all
#                cvs features (commits, adds) and all USE flags in SRC_URI
#                will be applied for digests.
#  'digest'      autogenerate a digest for packages.
#  'distcc'      enables distcc support via CC.
#  'fixpackages' allows portage to fix binary packages that are stored in
#                PKGDIR. This can consume a lot of time. 'fixpackages' is
#                also a script that can be run at any given time to force
#                the same actions.
#  'keeptemp'    prevents the clean phase from deleting the temp files ($T)
#                from a merge.
#  'keepwork'    prevents the clean phase from deleting the WORKDIR.
#  'noauto'      causes ebuild to perform only the action requested and
#                not any other required actions like clean or
#  'noclean'     prevents portage from removing the source and temporary 
files
#                after a merge -- for debugging purposes only.
#  'nostrip'     prevents stripping of binaries.
#  'notitles'    disables xterm titlebar updates (which contain status 
info).
#  'sandbox'     enable sandbox-ing when running emerge and ebuild
#  'strict'      causes portage to react strongly to conditions that
#                have the potential to be dangerous -- like missing or
#                incorrect Manifest files.
#  'userpriv'    allows portage to drop root privleges while it is compiling
#                as a security measure, and as a side effect this can remove
#                sandbox access violations for users.
#  'usersandbox' enables sandboxing while portage is running under userpriv.
#                unpack -- for debugging purposes only.
#FEATURES="sandbox buildpkg ccache distcc userpriv usersandbox notitles 
noclean noauto cvs keeptemp keepwork"

>+ ROCK Linux has a real
>sandbox build environment, not this optimization via CFLAGS, and so on
>Gentoo wannabe.
>  
>
That's not right either, you can have your own sandbox (see above) in 
Gentoo in additional to custom CFLAGS and USE flags that customize which 
packages play with other packages.

>And when you read some ebuild scripts you find
>the ROCK Linux automatics and tag based ASCI package description
>format very pleasant, e.g.:
>
You can pimp ROCK without trying to knock Gentoo; Gentoo is quite 
powerful, well supported, and easy to extend customize.

-ryan
