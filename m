Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTDYIxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDYIxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:53:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13583 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263482AbTDYIxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:53:13 -0400
Message-ID: <3EA8FAD2.4090200@aitel.hist.no>
Date: Fri, 25 Apr 2003 11:07:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com> <20030424214116.097D912EABA@mx12.arcor-online.net> <1051224351.4005.87.camel@dhcp22.swansea.linux.org.uk> <20030424235817.B25D73BD4F@mx01.nexgo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Fri 25 Apr 03 00:45, Alan Cox wrote:
[...]
>>In the MUD world we solved that by not telling anyone about objects they
>>can't see.
> 
> Doing the visibility calculations on the server, down to the pixel, is 
> possible but not really practical.
> 
Sure, but one can do better than quake.  The server can have
a look at the "terrain" at startup, and divide it into a
bunch of regions and calculate which regions cannot
bee seen from each other.  You can then do
fast simplified visibility calculation on the server,
by looking up positions in a lookup table. Players
in tunnels and such isn't visible from most of the
level so such structures would then provide the
desired surprises - even for cheaters.

Also, one can use a representation that makes it hard for
an AI to guess what is "wall" and what is a "player".
The players could be polygons just like everything else,
and a good level would have more moving items than
players so movement detection won't be a good
heuristic either.

Helge Hafting




