Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131431AbQKJS40>; Fri, 10 Nov 2000 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbQKJS4Q>; Fri, 10 Nov 2000 13:56:16 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56845 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131431AbQKJS4B>; Fri, 10 Nov 2000 13:56:01 -0500
Message-ID: <3A0C43D0.14039937@timpanogas.org>
Date: Fri, 10 Nov 2000 11:52:00 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: wmaton@ryouko.dgim.crc.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <Pine.GSO.3.96LJ1.1b7.1001110135209.27803A-100000@ryouko.dgim.crc.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"William F. Maton" wrote:
> 
> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> >
> > The sendmail folks are claiming that the TCPIP stack in Linux is broken,
> > which is what they claim is causing problems on sendmail on Linux
> > platforms.  Before anyone says, "don't use that piece of shit sendmail,
> > use qmail instead", perhaps we should look at this problem and refute
> > these statements -- I think that sendmail is causing this problem.  The
> > version is sendmail 8.9.3
> 
> What about sendmail 8.11.1?  Is the problem there too?

Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
encryption.
> 
> >
> > I can reproduce this bug on RH6.2, RH7.0, Caldera 2.2, 2.3, and 2.4,
> > Suse 6.X versions, and any of these distributions with the following
> > kernels.
> >
> > 2.2.14, 2.2.16, 2.2.17, 2.2.18, 2.4.0 (all).  What happens is that
> > sendmail fails to forward mails with any attachments larger than 400K,
> > and they just sit in the /var/spool/mqueue directory for up to a week,
> > and eventually get delivered.
> >
> > ANyone have any ideas if what the sendmail people are saying is on the
> > level, or is this just another sendmail bug.
> >
> > Jeff
> 
> wfms
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
