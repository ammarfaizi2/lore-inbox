Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310803AbSCHKnJ>; Fri, 8 Mar 2002 05:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310804AbSCHKnA>; Fri, 8 Mar 2002 05:43:00 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:63177 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S310803AbSCHKmx>;
	Fri, 8 Mar 2002 05:42:53 -0500
Message-ID: <3C8895A9.9090705@nokia.com>
Date: Fri, 08 Mar 2002 12:42:49 +0200
From: Marko Kohtala <Marko.Kohtala@nokia.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: fi, en
MIME-Version: 1.0
To: dalecki@evision-ventures.com
CC: linux-kernel@vger.kernel.org
Subject: RE: Removable IDE devices problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2002 10:42:49.0894 (UTC) FILETIME=[FE1AC460:01C1C68D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Your analysis of the problem is entierly right, since the current
 > kernel behaviour for removable media is supposed to work for
 > floppies (never get this thing out of your computer
 > as long as long the diode blinks) or read only media where it doesn't
 > really matter. However I still don't see a good way to
 > resolve this issue. (Maybe just adding buffer cache flush before
 > going into the check_media_change business of "grocking" partitions
 > would be sufficient...

But there is ide-floppy and ide-cd with their own media_check functions.

I'm thinking about ignoring the removable bit, at least when the device 
does not have door lock. What would be hurt by it?

P.S. Sorry for the previous mail with long lines. I should know better 
than using Outlook...


