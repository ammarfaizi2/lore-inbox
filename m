Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289364AbSBEKMd>; Tue, 5 Feb 2002 05:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSBEKMV>; Tue, 5 Feb 2002 05:12:21 -0500
Received: from picton-ext.nt.tas.gov.au ([202.7.15.63]:37286 "EHLO
	picton-ext.nt.tas.gov.au") by vger.kernel.org with ESMTP
	id <S289364AbSBEKML>; Tue, 5 Feb 2002 05:12:11 -0500
Date: Tue, 5 Feb 2002 21:12:01 +1100 (EST)
Message-Id: <200202051012.g15AC1n24106@picton-ext.nt.tas.gov.au>
From: "Andrew Griffiths" <andrewg@tasmail.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Importance: Normal
X-Mailer: VisualMail 3.0 ( http://www.minter.com.ar/visualmail )
Subject: Re: ptrace allows you to read -r files
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

After talking to some people, they confirm it is known, but what is the point of -r'ing binaries it if it can be read?

While it may not be a direct security threat, being able to look inside an otherwise unreadable binary can be a problem, for example, seeing if it is working or not, or possibly got entries for format strings.

Also some programs have a secret value inside them they use for authenication with remote clients. (Possibly Q by mixter @ mixter.warrior2k.com rings a bell).

While I guess there is no standard for ptrace, what do the other operating systems do? I've been told freebsd won't allow you to ptrace() a non-readable binary, but unable to confirm it myself.

On Monday, February 04, 2002 at 10:06:28 PM, Daniel Jacobowitz wrote:

> On Tue, Feb 05, 2002 at 11:33:32AM +1100, Andrew Griffiths wrote:
> > For those who want some demo code, you can find it at http://203.39.161.186/readbin.tgz.
>>
> I think this is just 'known'.  Note that it isn't a security problem
> otherwise; you'll find that the setuid application does not setuid if
> it is ptraced.  On 2.4.17 at least.
> 
> 

--
www.tasmail.com


