Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWBLKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWBLKBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBLKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:01:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7380 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964829AbWBLKBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:01:47 -0500
Date: Sun, 12 Feb 2006 11:01:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43ECA3FC.nailJGC110XNX@burner>
Message-ID: <Pine.LNX.4.61.0602121101070.25363@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > The struct stat->st_rdev field need to be stable too to comply to POSIX?
>> > Correct.
>A particular file on the system must not change st_dev while the system
>is running.
>

Attention, I asked for st_rdev (=major/minor as presented in ls -l),
not st_dev (major/minor of the disk /dev is on).


Jan Engelhardt
-- 
