Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbULaPAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbULaPAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbULaPAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:00:39 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:37254 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S262100AbULaO6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:58:41 -0500
Date: Sat, 27 Nov 2004 12:50:38 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: file as a directory
Message-ID: <20041127115037.GA6132@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com> <41A23496.505@namesys.com> <1101287762.1267.41.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101287762.1267.41.camel@pear.st-and.ac.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 09:16:03AM +0000, Peter Foldiak wrote:
> So if you have a file named "/home/peter/book", you should be able to
> look at its Introduction as "/home/peter/book/Introduction" or chapter
> 3, paragraph 2 as
> /home/peter/book/chapter[3]/paragraph[2]
> 
> In this case you could use 
> /home/peter/book/chapter[3]/paragraph[2]
> as a "real" file, read it, even edit it in a text editor. When you later
> look at the whole book as /home/peter/book , you should see your
> changes.

 First, this kind of document storage needs extensive knowledge of
assocatied metadata and therefore is insuitable for kernel. It should be
done in userspace.
 Second, it is beeing done in userspace - http://www.gnome.org/~seth/storage/ .
No need to reinvent the wheel.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev

