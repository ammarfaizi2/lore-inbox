Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWBJOyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWBJOyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWBJOyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:54:13 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25264 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751276AbWBJOyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:54:11 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 15:52:44 +0100
To: schilling@fokus.fraunhofer.de, cfriesen@nortel.com
Cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43ECA8BC.nailJHD157VRM@burner>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com>
In-Reply-To: <43ECA70C.8050906@nortel.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortel.com> wrote:

> > A particular file on the system must not change st_dev while the system
> > is running.
> > 
> > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
>
>
> I don't actually see that requirement listed there. It says that st_dev 
> must be unique, and that all files are uniquely identified by st_ino and 
> st_dev.
>
> There's nothing there that says the mapping cannot change with 
> time...just that it has to be unique.

If it changes over the runtime of a program, it is not unique from the
view of that program.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
