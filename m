Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273994AbRJDO15>; Thu, 4 Oct 2001 10:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJDO1r>; Thu, 4 Oct 2001 10:27:47 -0400
Received: from web11806.mail.yahoo.com ([216.136.172.160]:28423 "HELO
	web11806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273994AbRJDO1e>; Thu, 4 Oct 2001 10:27:34 -0400
Message-ID: <20011004142803.72199.qmail@web11806.mail.yahoo.com>
Date: Thu, 4 Oct 2001 16:28:03 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: specific optimizations for unaccelerated framebuffers
To: linux-kernel@vger.kernel.org
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>
In-Reply-To: <3BBC6BBD.128161B5@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Christopher Friesen <cfriesen@nortelnetworks.com> wrote:
> >   Been able to DMA the complete video memory image around 5-10
> > times/second should be over the human eye sensitivity.
> 
> Since anything less than 75Hz gives me headaches, how do you propose to
> make this work?

  Because there is still memory on the video board, the display stay
 at whatever refresh the video board is set up, 80 Hz if you want.

 That is updating the video memory from main memory which is at 10 Hz,
 if a dot is displayed in another color for a duration of 0.01 second
 (100 Hz), the human eye will not see it, so there is no need to
 display it.

 I am _not_ a specialist of the eye, but if something is displayed for
 less than 1/10 of a second, I am not sure to see it. So I can probably
 accept to have a 100 ms delay in between a click and the associated
 window appearing.

  Etienne.


___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
