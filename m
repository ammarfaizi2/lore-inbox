Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTHYP4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTHYP4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:56:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:10197 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261741AbTHYPzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:55:55 -0400
Message-ID: <3F4A2FC7.1060602@namesys.com>
Date: Mon, 25 Aug 2003 19:48:23 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>	<03080409334500.03650@tabby>	<20030804170506.11426617.skraw@ithnet.com>	<03080416092800.04444@tabby>	<20030805003210.2c7f75f6.skraw@ithnet.com>	<3F2FA862.2070401@aitel.hist.no>	<20030805150351.5b81adfe.skraw@ithnet.com>	<20030805220831.GA893@hh.idb.hist.no>	<3F48F77D.7040907@namesys.com> <16201.51310.181117.716100@laputa.namesys.com>
In-Reply-To: <16201.51310.181117.716100@laputa.namesys.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
> >
>
>[...]
>
> > So, he needs links that count as references, links that don't count as 
> > references but disappear if the object disappears (without dangling like 
> > symlinks), and unlinkall(), which removes an object and all of its 
> > links.  He needs for the first reference to a directory to be removable 
> > only by removing all links to the object, or designating another link to 
> > be the "first" reference.
> > 
> > Sounds clean to me.  
>
>Will surely continue to be this way until you start implementing. :)
>
> >                      This is not to say that I am funded to write 
> > it.;-)  I'd look at a patch though.....;-)
> > 
> > I need to write up a taxonomy of links..... after reiser4 ships.....
>
>http://www.namesys.com/v4/links-taxonomy.html
>
> > 
> > -- 
> > Hans
> > 
>
>Nikita.
>
> > 
>
>
>  
>
I meant one that is intelligible to the reader and comes with a detailed 
explanation.;-)

Also, I am sure we need another round of seminars on it.

-- 
Hans


