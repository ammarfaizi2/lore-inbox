Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132271AbRCVX6b>; Thu, 22 Mar 2001 18:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132245AbRCVXzt>; Thu, 22 Mar 2001 18:55:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:17678 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132246AbRCVXyo>; Thu, 22 Mar 2001 18:54:44 -0500
Date: Thu, 22 Mar 2001 20:53:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3C9BCD6E.94A5BAA0@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0103222052100.24040-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Martin Dalecki wrote:

> Uptime of a process is a much better mesaure for a killing
> candidate then it's size.

You'll have fun with your root shell, then  ;)

The current OOM code takes things like uptime, used cpu, size
and a bunch of other things into account.

If it turns out that the code is not attaching a proper weight
to some of these factors, you should be sending patches, not
flames.

(the code is full of comments, so it should be easy enough to
find your way around the code and tweak it until it does the
right thing in a number of test cases)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

