Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130881AbQKJSxg>; Fri, 10 Nov 2000 13:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbQKJSx0>; Fri, 10 Nov 2000 13:53:26 -0500
Received: from ryouko.dgim.crc.ca ([142.92.39.75]:10883 "EHLO
	ryouko.dgim.crc.ca") by vger.kernel.org with ESMTP
	id <S130881AbQKJSxM>; Fri, 10 Nov 2000 13:53:12 -0500
Date: Fri, 10 Nov 2000 13:52:30 -0500 (EST)
From: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>
Reply-To: wmaton@ryouko.dgim.crc.ca
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  /var/spool/mqueue]
In-Reply-To: <3A0C4252.100D863D@timpanogas.org>
Message-ID: <Pine.GSO.3.96LJ1.1b7.1001110135209.27803A-100000@ryouko.dgim.crc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> 
> The sendmail folks are claiming that the TCPIP stack in Linux is broken,
> which is what they claim is causing problems on sendmail on Linux
> platforms.  Before anyone says, "don't use that piece of shit sendmail,
> use qmail instead", perhaps we should look at this problem and refute
> these statements -- I think that sendmail is causing this problem.  The
> version is sendmail 8.9.3

What about sendmail 8.11.1?  Is the problem there too?

> 
> I can reproduce this bug on RH6.2, RH7.0, Caldera 2.2, 2.3, and 2.4,
> Suse 6.X versions, and any of these distributions with the following
> kernels.   
> 
> 2.2.14, 2.2.16, 2.2.17, 2.2.18, 2.4.0 (all).  What happens is that
> sendmail fails to forward mails with any attachments larger than 400K,
> and they just sit in the /var/spool/mqueue directory for up to a week,
> and eventually get delivered.
> 
> ANyone have any ideas if what the sendmail people are saying is on the
> level, or is this just another sendmail bug.  
> 
> Jeff



wfms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
