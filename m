Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314735AbSEDRMh>; Sat, 4 May 2002 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314747AbSEDRMg>; Sat, 4 May 2002 13:12:36 -0400
Received: from relay1.pair.com ([209.68.1.20]:50697 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314735AbSEDRMg>;
	Sat, 4 May 2002 13:12:36 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD41727.64D626D6@kegel.com>
Date: Sat, 04 May 2002 10:15:19 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arjan@fenrus.demon.nl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: khttpd newbie problem
In-Reply-To: <200205041600.g44G0J708618@pc3-camc5-0-cust13.cam.cable.ntl.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> Dan Kegel wrote:
> > I can't get khttpd to serve any requests.
> >
> > echo /home/dank/stress > /proc/sys/net/khttpd/documentroot
> > echo 80 > /proc/sys/net/khttpd/serverport
> > echo 8000 > /proc/sys/net/khttpd/maxconnect
> > echo 1 > /proc/sys/net/khttpd/start
> 
> what did you set the client port to ?

That was it.  I finally read /usr/src/net/khttpd/README,
and I should be ok now.  I am such a dork sometimes.

Thanks,
Dan

p.s. also found http://lists.alt.org/pipermail/khttpd-users/
which should be helpful.
