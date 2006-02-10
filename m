Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWBJOpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWBJOpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBJOpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:45:42 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:44031 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751089AbWBJOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:45:41 -0500
Message-ID: <43ECA70C.8050906@nortel.com>
Date: Fri, 10 Feb 2006 08:45:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner>
In-Reply-To: <43ECA3FC.nailJGC110XNX@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 14:45:34.0403 (UTC) FILETIME=[A601B930:01C62E50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> "Theodore Ts'o" <tytso@mit.edu> wrote:

>>Can you please list the POSIX standard, section, and line number which
>>states that a particular device must always have the same st_rdev
>>across reboots, and hot plugs/unplugs?
> 
> 
> A particular file on the system must not change st_dev while the system
> is running.
> 
> http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html


I don't actually see that requirement listed there. It says that st_dev 
must be unique, and that all files are uniquely identified by st_ino and 
st_dev.

There's nothing there that says the mapping cannot change with 
time...just that it has to be unique.

Chris
