Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSICPk0>; Tue, 3 Sep 2002 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318198AbSICPk0>; Tue, 3 Sep 2002 11:40:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16390 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318139AbSICPkY>; Tue, 3 Sep 2002 11:40:24 -0400
Date: Tue, 3 Sep 2002 12:44:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209031539.g83FdVb02733@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209031243450.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> I assumed that I would need to make several VFS operations atomic
> or revertable, or simply forbid things like new file allocations or
> extensions (i.e.  the above), depending on what is possible or not.

> No, I don't want ANY FS. Thanks, I know about these, but they're not
> it. I want support for /any/ FS at all at the VFS level.

You can't.  Even if each operation is fully atomic on one node,
you still don't have synchronisation between the different nodes
sharing one disk.

You really need filesystem support.

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

