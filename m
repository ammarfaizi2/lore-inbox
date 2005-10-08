Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVJHQty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVJHQty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVJHQty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:49:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59098 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932157AbVJHQtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:49:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Marc Perkel <marc@perkel.com>
Subject: Re: what's next for the linux kernel?
Date: Sat, 8 Oct 2005 19:49:39 +0300
User-Agent: KMail/1.8.2
Cc: Nix <nix@esperi.org.uk>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       7eggert@gmx.de, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
References: <4TiWy-4HQ-3@gated-at.bofh.it> <874q7vhj0c.fsf@amaterasu.srvr.nix> <434429F2.7030400@perkel.com>
In-Reply-To: <434429F2.7030400@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081949.40028.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 October 2005 22:30, Marc Perkel wrote:
> >So, um, what happens to these permissions when you copy a file and put
> >it somewhere else? Do the inherited rights go with it or not? In Unix
> >it's pretty intuitive. In this system there seem to be two right
> >answers, both of which seem... risky from a security perspective.
> >  
> >
> You inherit the rights of the new directory.
> 
> Also - under Netware not all permissions are stored with the file. The 
> rights are calculated from the file heirachy so you don't store a lot of 
> data with each file unless the file has permissions set that is 

Since when 16 bits is a lot of data?

> different than that of the directory it's in. So moving a file to 
> someone's home directory doesn't require any permissions to be set to 
> give the user rights to the file.
> 
> >/tmp is the problem here, and shows the futility and pointlessness of
> >this feature. If you have an unlistable file in /tmp, *its name is still
> >determinable*, because other users cannot create files with that
> >name. The concept adds *nothing* over some combination of dirs with the
> >execute bit cleared for some set of users and subdirectories which
> >cannot be read by some set of users. There's no need for this profoundly
> >non-Unixlike permission at all. (As usual, ACLs make managing this on
> >a fine-grained scale rather easier.)
> >
> It doesn't really make sense to use the /tmp directory the way Unix uses 
> it. Why would you want just anyone to even know the names of the 
> temporary files you are using. Users should have their own temp 
> directory or create their own directory within /tmp

Then use ~/tmp in your homedir. What's the problem?

> >You *do* realise just how incapable the Windows permission-management
> >GUI is, don't you? Any OS where the command-line tools hide half
> >the permissions model and the GUI hides a slightly different half,
> >and where looking at a set of permissions and hitting cancel can
> >*change* those permissions drastically, is not sane.
> >  
> >
> That's why I'm pushing netware as a model rather than windows. But 
> Windows file permissions are superior to Linux.
> 
> >(Disclaimer: the last time I bothered to verify the latter behaviour
> >was in NT4. Maybe they've partially fixed it.)
> 
> One place where Windows wins over Linux is in the "easy to use" 
> category. Something the Linux world should look ast.

"Easy to use" to whom?

Command line tools for changing permissions under Windows are anything
but "easy to use". They are also feature incomplete. Tools for changing
ownership do not exist at all. Tools for changing permissions/ownership
on registry do not exist also. Maybe third party ones exist, dunno.
Every one that I saw on the Inet, was either buggy, incomplete, or both.

For admins, this is a huge hole in usability.

> I am a Linux supporter and love it. I'm saying this to help make it better.
--
vda
