Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWEQLrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWEQLrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 07:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWEQLrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 07:47:24 -0400
Received: from web26603.mail.ukl.yahoo.com ([217.146.176.53]:53616 "HELO
	web26603.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750872AbWEQLrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 07:47:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Wp8XmT6XaR9J79nt6iZjedLoiCUcZVd6CZ7FUh2SjtTJJlhtLxaYlrYHgCLcIjYd9E6gguVCaRUXoTTNhPmlrbZBP7e1Tg+kA2btptFPNaGs6/WaXL13Fnybli9/U0ZrdW1ksdRn5WFylCvGDsthdinF5pkMrMezngi5mQ4z+Jk=  ;
Message-ID: <20060517114722.90648.qmail@web26603.mail.ukl.yahoo.com>
Date: Wed, 17 May 2006 13:47:22 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605161513590.24814@blackbox.fnordora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

X Window System has many problems affecting directly
the kernel.

http://en.wikipedia.org/wiki/X_Window_System#Limitations_and_criticisms_of_X
-Many current implementations of X manipulate the
video hardware directly.
-X deliberately contains no specification as to user
interface or most inter-application communication.
-The X protocol provides no facilities for handling
sound,
-Until recently, X did not include a good solution to
print screen-displays. 
-One cannot currently detach an X client or session
from one server and reattach it to another.

I would add :
-X needs to be root so it opens many security holes.
-X has more code than the kernel and it is almost an
OS in itself.
-if a "closed-source" graphical card driver has
security holes, what do you do ?
etc.

Some people are working on replacement like Y windows
:
http://www.doc.ic.ac.uk/teaching/projects/Distinguished03/MarkThomas.pdf
http://www.y-windows.org/

There are some questions like :
- should the next generation window versions Y,Z etc.
remain backward compatible with X ?
I think they should start something better and simpler
from scratch and not backward compatible.
- should the kernel remain pure "shell" or include
some basic universal graphical universal window system
?
I think second answer.


Regards.












	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
