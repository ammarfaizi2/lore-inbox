Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWDSTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWDSTIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWDSTIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:08:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50128 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750893AbWDSTIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:08:11 -0400
Date: Wed, 19 Apr 2006 21:06:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <1145462454.3085.62.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
References: <200604021240.21290.edwin@gurde.com>  <200604072138.35201.edwin@gurde.com>
  <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> 
 <200604142301.10188.edwin@gurde.com>  <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
  <20060417162345.GA9609@infradead.org>  <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
  <20060417173319.GA11506@infradead.org>  <Pine.LNX.4.64.0604171454070.17563@d.namei>
  <20060417195146.GA8875@kroah.com>  <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Well then, have a look at http://alphagate.hopto.org/multiadm/
>> 
>
>hmm on first sight that seems to be basically an extension to the
>existing capability() code... rather than a 'real' LSM module. Am I
>missing something here?
>

(So what's the definition for a "real" LSM module?)

It's quite a "big" extension to the capability code inasfar as that 
access is not solely granted based on capabilities, but a matrix of 
capabilities plus UID/GID of filesystem objects.

This is not a "for fun" LSM like rootplug, but it was specifically 
developed to address some permission issues in an educational institution. 
The LSM hooks were there (and some more are added with MultiAdm), and it 
seemed a lot simpler than setting up SELinux.


Jan Engelhardt
-- 
