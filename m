Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284942AbRLQASD>; Sun, 16 Dec 2001 19:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284945AbRLQARx>; Sun, 16 Dec 2001 19:17:53 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:10427
	"HELO tabris.net") by vger.kernel.org with SMTP id <S284942AbRLQARl>;
	Sun, 16 Dec 2001 19:17:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Subject: Re: Is /dev/shm needed?
Date: Sun, 16 Dec 2001 19:17:34 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com> <20011216234748.3EDE9FB80D@tabris.net> <E16Fl8j-0000nA-00@phalynx>
In-Reply-To: <E16Fl8j-0000nA-00@phalynx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011217001735.D9D6BFB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 December 2001 18:56, Ryan Cumming wrote:
> On December 16, 2001 15:47, Adam Schrotenboer wrote:
> > I may be wrong about /tmp as well, but I have come to think that it is
> > data that ought be discarded after logout, and have sometimes considered
> > writing a script for it in the login/logout scripts.
>
> System daemons can legally use /tmp, and they may not apprechiate having
> their files removed from underneath them everytime someone telnets in. ;)
Definite pt. So maybe make mortal users use $HOME/tmp. and that could be 
mounted at login and umounted at logout. Or, rm only the files that the user 
owns.
>
> -Ryan

-- 
tabris

   "I wanted to see exotic Vietnam, the jewel of Southeast Asia. I wanted
   to meet interesting and stimulating people of an ancient culture...
   and kill them."

                                               Joker, "Full Metal Jacket"

