Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTENPJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTENPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:09:35 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:41891 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S262454AbTENPJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:09:32 -0400
Message-ID: <20030514152247.4146.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Dean McEwan" <dean_mcewan@linuxmail.org>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Wed, 14 May 2003 15:22:46 +0000
Subject: Re: Digital Rights Management - An idea (limited lease, renting,
    expiration, verification) NON HAR*D*WARE BASED.
X-Originating-Ip: 213.120.30.217
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: 14 May 2003 14:49:03 +0100 
To: Dean McEwan <dean_mcewan@linuxmail.org>
Subject: Re: Digital Rights Management - An idea (limited lease, renting, expiration, verification) NON HARWARE BASED.

> On Mer, 2003-05-14 at 14:52, Dean McEwan wrote:
> > It would be set up so that files have an internal signature (ELF format might have to be
> > fiddled with). It would verify itself by sending info to the creator of the contents PC OR server
> > asking for verification of itself, files could be limited lease, rented, or automatically expire 
> > after some time.
> 
> That way around doesnt actually work because I'll simply lie, fake the server or firewall you

Encrypted binary, in a XML wrapper that needs decryption key from owners site.
Uses port 80...
> (in fact any serious business firewalls all outgoing traffic from end users). If you want
> to do it for internal trust and you control the systems (the useful case) you set SELinux
> or RSBAC up so that all applications create files in a "non runnable" class. The only way
> to transition an app is a single user application which does your key checking and other
> processing then transitions the binary to "safe". I guess you also add a general rule that
> writing to a file moves it back into non runnable.
> 
> One of the problems with this is interpreters. Its easy to do this with ELF binaries but
> you have to extend it to scripts and that normally means more pain 8)
> 
> 
> 

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
