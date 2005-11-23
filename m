Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVKWD0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVKWD0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKWD0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:26:39 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:19908 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932493AbVKWD0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:26:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ko/1s5O1jc5ipl14UU1Q0DPvUKSNvA5kVrpyt6nH+ikjCCeTWQYL7A60FA+RE38f+RoEj3poAe8/Ql2O/I3yOpJObJEUp44xOcw3mZ6gTtDl/Gi4AeCacJLq5DzB1IobYCcIPDsMABgMuob3UzGdna7gKn1yhlq5ntGCgEqCyxk=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Small PCI core patch
Date: Tue, 22 Nov 2005 22:26:15 -0500
User-Agent: KMail/1.8.3
Cc: Matthieu CASTET <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org
References: <20051121225303.GA19212@kroah.com> <pan.2005.11.22.18.26.54.534251@free.fr> <1132690509.20233.71.camel@localhost.localdomain>
In-Reply-To: <1132690509.20233.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511222226.16550.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 15:15, Alan Cox wrote:
> On Maw, 2005-11-22 at 19:26 +0100, Matthieu CASTET wrote:
> > Why not make a crappy GPL driver that just export again
> > the symbols ?
> 
> Because if you have to do tha your non GPL driver is a derivative work
> of your GPL driver ...

Yes but I don't necessarily need license from the GPL to distribute a
derived work. What I need is permission from the copyright holders my
proprietary driver is a derived work of, the GPL is merely one mechanism
to get that permission. Permission from the GPLed driver, namely me,
is easy enough for me to obtain. Permission from the authors of any other
Linux code my propriety driver is a derivative work of is probably going
to be impossible to obtain. So it seems to me that the relevant question
is whether my (hypothetical) proprietary driver is a derivative work of
any Linux code I did not write myself. I do not believe that "derivative
work of" is transitive, so it does not necessarily follow that my
propriety driver is a derivative work of any other code just because
it is a derivative work of my GPL driver. However:

1) I am not a Lawyer. 

2) If my driver was a derivative work of the kernel when it was using
_GPL symbols, adding a shim between it and the kernel isn't going to
change matters.

3) The _GPL annotation is a really strong hint that the authors of code
would consider my proprietary driver a derivative work, and do not give
any permission for me to use their code _except_ under the GPL. If my
proprietary driver is a derivative work of someone else's code, I'm in
trouble.

Andrew
