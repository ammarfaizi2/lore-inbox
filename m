Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRDBOe2>; Mon, 2 Apr 2001 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRDBOeT>; Mon, 2 Apr 2001 10:34:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37126 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129486AbRDBOeC>; Mon, 2 Apr 2001 10:34:02 -0400
Date: Mon, 2 Apr 2001 11:32:00 -0300
From: Gustavo Niemeyer <niemeyer@conectiva.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
Message-ID: <20010402113200.D15554@tux.distro.conectiva>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01033016225700.00409@dennis> <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de> <20010402095425.A15554@tux.distro.conectiva> <20010402153354.A15933@indexdata.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010402153354.A15933@indexdata.dk>; from adam@indexdata.dk on Mon, Apr 02, 2001 at 03:33:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> People making Apache 1.3.X modules have a problem too. They have to
> rebuilt Apache and add -lpthread if any modules uses threads.

It seems to be the same case here.

> The following small program illustrates this. The program, main-wot,
> crashes  - the other, main-wt, doesn't.
[...]

Both work here... am I doing something wrong (or right :-)??

I've tried to reduce to a testcase like this before, and it has worked
as well. I don't understand what this limitation is about.

-- 
Gustavo Niemeyer

[ 2AAC 7928 0FBF 0299 5EB5  60E2 2253 B29A 6664 3A0C ]
