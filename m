Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310171AbSCPQJD>; Sat, 16 Mar 2002 11:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310423AbSCPQIx>; Sat, 16 Mar 2002 11:08:53 -0500
Received: from host194.steeleye.com ([216.33.1.194]:45321 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310171AbSCPQIi>; Sat, 16 Mar 2002 11:08:38 -0500
Message-Id: <200203161608.g2GG8WC05423@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository. 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Thu, 14 Mar 2002 23:55:08 EST." <3C917EAC.1080401@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 11:08:32 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@mandrakesoft.com said:
> Through the magic of BK :)

> Just do a 'bk pull' on my marcelo-2.4 tree.  Since it is based on the
> original linux-2.4 tree just like Marcelo's tree, I was able to merge
> from my 2.4 line to his 2.4 line. 

Well, I tried this, but it just gave me a slew of initial rename conflicts.  
It could be something to do with the fact that my base development is still on 
2.4.18 (so the ancestors are easier to manage).

I finally solved it by writing a script to backport a bitkeeper change set to 
an earlier ancestor while preserving the change logs.  This is going to be 
helpful taking change sets between 2.4 and 2.5 anyway.

Thanks,

James


