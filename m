Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTHaROw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTHaROw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:14:52 -0400
Received: from users.linvision.com ([62.58.92.114]:8654 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262474AbTHaROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:14:50 -0400
Date: Sun, 31 Aug 2003 19:14:19 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Hans Reiser <reiser@namesys.com>
Cc: erik@hensema.net, linux-kernel@vger.kernel.org,
       Nikita Danilov <god@laputa.namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030831191419.A23940@bitwizard.nl>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F50D986.6080707@namesys.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 09:06:14PM +0400, Hans Reiser wrote:
> >df: `/reiser4': Value too large for defined data type
> >df: `/home': Value too large for defined data type

Hans, 

Would it be possible to do something like: "pretend that there
are always 100 million inodes free", and then report sensible
numbers to "df -i"? 

There  is no installation program that will fail with: "Sorry, 
you only have 100 million inodes free, this program will need
132 million after installation", and it allows me a quick way 
of counting the number of actual files on the disk.... 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
