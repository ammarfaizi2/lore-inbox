Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUBQIdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUBQIdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:33:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:65498 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263832AbUBQIdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:33:33 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: tridge@samba.org
Date: Tue, 17 Feb 2004 19:33:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16433.53708.264048.307137@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: message from tridge@samba.org on Tuesday February 17
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 17, tridge@samba.org wrote:
> 
> I also think that if the choice were given then some linux distros
> (the likes of Lindows comes to mind) would choose to run all processes
> case-insensitive. These sorts of distros are aiming at the sorts of
> users that would want everything to be case-insensitive.

This is the bit I don't understand.

Surely the value of case-insensitivity is that you can type in a
filename from memory and not worry about what case you used when you
created the file.

Yet with Lindows / MS-Windows style interfaces, you virtually never
type the name of a pre-existing file.  So case-insensitivity doesn't
seem to be a win to the user.

I thought the value of a case-insensitive filenames was for
legacy applications which have been written to the WIN32 API and took
lots of liberties with "pretty-casing" filenames between readdir and
open. 

NeilBrown
