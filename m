Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVILCpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVILCpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 22:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVILCpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 22:45:40 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:28249 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751134AbVILCpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 22:45:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: git@vger.kernel.org
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 21:45:33 -0500
User-Agent: KMail/1.8.2
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509112145.33994.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 20:39, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Btw, there's no reason why a client-side thing couldn't just parse the 
> > "alternates" thing, and if it doesn't find the objects in the main object 
> > directory, go and fetch them from the alternates itself.
> 
> There is.
> 
> For kernel.org, you could say '/pub/scm/blah' in your alternates
> and expect it to work, only because http://kernel.org/pub
> hierarchy happens to match the absolute path /pub on the
> filesystem, but for most people's default HTTP server
> installation, they would need to say /var/www/scm/blah to have
> alternate work locally, but somebody has to know that the named
> directory is served as http://machine.xz/pub/scm/blah somewhere.
> 

Call me brain-dead but all of this just makes me rsync my tree to
kernel.org and then manually do "ln -f" for all the packs that Linus
has. This way I am sure tht the tree is what I have plus and it is
"pullable".


-- 
Dmitry
