Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284929AbRLPXsU>; Sun, 16 Dec 2001 18:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbRLPXsK>; Sun, 16 Dec 2001 18:48:10 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:8891
	"HELO tabris.net") by vger.kernel.org with SMTP id <S284929AbRLPXry>;
	Sun, 16 Dec 2001 18:47:54 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: =?iso-8859-1?q?Ra=FAl=20N=FA=F1ez=20de=20Arenas=20Coronado?= 
	<raul@viadomus.com>,
        rml@tech9.net
Subject: Re: Is /dev/shm needed?
Date: Sun, 16 Dec 2001 18:47:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com>
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011216234748.3EDE9FB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 December 2001 18:37, Raúl Núñez de Arenas Coronado wrote:
>     Hello Adam :))
>
> >> have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> >> in tmpfs.
> >
> >Unfortunately, some(many?) distros are b0rken in re /var/. There is
> >stuff put there that is needed across boots (for example, mandrake
> >puts the DNS master files in /var/named.)

Thank you for this correction of my understanding of /var
I now am under the impression that it merely means that /var must be mounted 
rw. It is for variables, but not discardable data.

This still means that the concept of a tmpfs /var is _severely_ broken. DON'T 
DO IT.

I may be wrong about /tmp as well, but I have come to think that it is data 
that ought be discarded after logout, and have sometimes considered writing a 
script for it in the login/logout scripts.

>
>     Moreover, didn't the LHS say that /var/tmp is supposed to be
> maintained across reboots? I'm not sure about this, but anyway /var
> is supposed to hold temporary data, not boot-throwable data, isn't
> it?
>
>     Raúl

-- 
tabris

   Once I swore I would die for you, but I never meant like this.

                                              Shame, by Stabbing Westward

