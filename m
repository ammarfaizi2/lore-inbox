Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbSJHBeJ>; Mon, 7 Oct 2002 21:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSJHBeJ>; Mon, 7 Oct 2002 21:34:09 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63365 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262584AbSJHBeI>; Mon, 7 Oct 2002 21:34:08 -0400
Date: Mon, 7 Oct 2002 20:39:46 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <levon@movementarian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: vpath broken in 2.5.41
In-Reply-To: <20021007232852.GA35308@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0210072037520.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, John Levon wrote:

> I see vpath seems to have become broken in 2.5.41 build.
> 
> How now can I build the oprofile.o target from two directories ?

I see in the patch you mailed later that you got it figured out already, 
using a relative path.
And yeah, it's not particularly beautiful. But I do not see any nice and 
easy way, either. What would help a lot, of course, would be to split this 
into two modules, one generic one, one arch-specific one. Have you 
considered doing that?

--Kai

