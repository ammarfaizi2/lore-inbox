Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRHAKcr>; Wed, 1 Aug 2001 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbRHAKch>; Wed, 1 Aug 2001 06:32:37 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:59662 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S266464AbRHAKc0>; Wed, 1 Aug 2001 06:32:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.2.13] memory leak in NFS if a sever goes away?
In-Reply-To: <tgsnfdkrsu.fsf@mercury.rus.uni-stuttgart.de>
	<20010731232456.A13258@emma1.emma.line.org>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 01 Aug 2001 12:32:19 +0200
In-Reply-To: <20010731232456.A13258@emma1.emma.line.org> (Matthias Andree's message of "Tue, 31 Jul 2001 23:24:56 +0200")
Message-ID: <tgy9p4jcjw.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> > Are there some known issues with 2.2.13, for example, a memory leak in
> > the NFS code which is triggered in this specific situation?
> 
> There are known security threats in 2.2.x which have been fixed in
> 2.2.16, and there have been VM fixes in a later version, and further
> minor but numerable security fixes in 2.2.19.

The system has already been installed from scratch, using a more
recent kernel version.  I agree that the kind of information I'm
looking for is not crucial for running a current Linux kernel, but we
were specifically asked to explain what has happened to the machine
(and we do have satisfactory explanations for other strange things
which were obsvered---no it wasn't hacked ;-), but this problem still
remains a bit mysterious.  I just wanted to make sure that the problem
described in my first posting is not a once well-known issue with
2.2.13 or other 2.2.x kernels, and that I didn't miss an obvious
explanation.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
