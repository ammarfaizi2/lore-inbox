Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSDOIsQ>; Mon, 15 Apr 2002 04:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSDOIsP>; Mon, 15 Apr 2002 04:48:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57349 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313114AbSDOIsO>; Mon, 15 Apr 2002 04:48:14 -0400
Message-ID: <3CBA936B.449A183@aitel.hist.no>
Date: Mon, 15 Apr 2002 10:46:35 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <E16wkJq-0004Jl-00@the-village.bc.nu> <20020415065501.3A687740@merlin.webofficenow.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> The killer is that if one person drives the machine into swap, performance
> melts down for everybody.  THAT is what makes the idea of a multi-headed
> linux box as a many-way shared workstation seem a lot less workable to me.

No problem.  This is precisely what "ulimit" is for - prevent single
users from grabbing too much resources on a multiuser machine.
Distributions default to not use it because most machines are
single-user,
this however is the occation where you need it.  Of course you can
afford
more RAM for the 4-user machine, and shared memory for kernel and
executable
code helps too...

Helge Hafting
