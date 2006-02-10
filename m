Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBJNKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBJNKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWBJNKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:10:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16595 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932079AbWBJNKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:10:18 -0500
Date: Fri, 10 Feb 2006 14:10:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43EC8E18.nailISDJTQDBG@burner>
Message-ID: <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
References: <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Well, this is a deficit of the Linux kernel - not libscg.
>>
>> This is exactly what I have written -- extra effort is needed to get
>> a stable numbering (which Solaris does), but you can use a very similar
>> extra care to get stable names (which Linux with udev does).
>
>As this conceptional deficite in Linux causes Linux to break POSIX
>compliance e.g. for stat(2) with hot plugged devices, people with 

The struct stat->st_rdev field need to be stable too to comply to POSIX?

>sufficient background knowledge should know that Linux tried to fix a 
>low level bug at a high level ignoring that the mid-level is still broken.


Jan Engelhardt
-- 
