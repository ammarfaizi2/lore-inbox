Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTHYI1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbTHYI13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:27:29 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60338 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261501AbTHYI12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:27:28 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16201.51310.181117.716100@laputa.namesys.com>
Date: Mon, 25 Aug 2003 12:27:26 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: FS: hardlinks on directories
In-Reply-To: <3F48F77D.7040907@namesys.com>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<3F2FA862.2070401@aitel.hist.no>
	<20030805150351.5b81adfe.skraw@ithnet.com>
	<20030805220831.GA893@hh.idb.hist.no>
	<3F48F77D.7040907@namesys.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 >

[...]

 > So, he needs links that count as references, links that don't count as 
 > references but disappear if the object disappears (without dangling like 
 > symlinks), and unlinkall(), which removes an object and all of its 
 > links.  He needs for the first reference to a directory to be removable 
 > only by removing all links to the object, or designating another link to 
 > be the "first" reference.
 > 
 > Sounds clean to me.  

Will surely continue to be this way until you start implementing. :)

 >                      This is not to say that I am funded to write 
 > it.;-)  I'd look at a patch though.....;-)
 > 
 > I need to write up a taxonomy of links..... after reiser4 ships.....

http://www.namesys.com/v4/links-taxonomy.html

 > 
 > -- 
 > Hans
 > 

Nikita.

 > 
