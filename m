Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSGLXOW>; Fri, 12 Jul 2002 19:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSGLXOV>; Fri, 12 Jul 2002 19:14:21 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:32520 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318062AbSGLXOV>; Fri, 12 Jul 2002 19:14:21 -0400
Date: Sat, 13 Jul 2002 01:17:06 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020712231705.GA19903@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D2EC778.7000203@evision-ventures.com> <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Linus Torvalds wrote:

> I will violently oppose anything that implies that the IDE layer uses the
> SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
> that should be scrapped is ide-scsi.
> 
> The higher layers already have much of what the SCSI layer does, and the
> SCSI layer itself is slowly moving in that direction.

Oh, and users will violently oppose when you meddle with drivers and any
user-space application stops working because of dropping ide-scsi on the
floor. I have been using ide-scsi for ages to drive CD-ROM (mostly) and
it's not given me headaches. I like being able to access my CD-ROM as
/dev/scd0 regardless if it's SCSI or ATAPI, and if any troubles had
arrived on hardware no older than 1997, ide-scsi has solved it for me.

-- 
Matthias Andree
