Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSICPJL>; Tue, 3 Sep 2002 11:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSICPJJ>; Tue, 3 Sep 2002 11:09:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15889 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318799AbSICPJE>; Tue, 3 Sep 2002 11:09:04 -0400
Date: Tue, 3 Sep 2002 12:13:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <200209031501.g83F1Oa31142@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209031211400.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> Rationale:
> No caching means that each kernel doesn't go off with its own idea of
> what is on the disk in a file, at least. Dunno about directories and
> metadata.

And what if they both allocate the same disk block to another
file, simultaneously ?

A mount option isn't enough to achieve your goal.

It looks like you want GFS or OCFS. Info about GFS can be found at:

	http://www.opengfs.org/
	http://www.sistina.com/  (commercial GFS)

Dunno where Oracle's cluster fs is documented.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

