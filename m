Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVGHRRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVGHRRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVGHRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:17:12 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37519 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262718AbVGHRRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:17:10 -0400
In-Reply-To: <Pine.LNX.4.61.0507081845170.3743@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Subject: Re: share/private/slave a subtree - define vs enum
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 8 Jul 2005 10:16:10 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_06092005|June 09, 2005) at
 07/08/2005 13:17:06,
	Serialize complete at 07/08/2005 13:17:06
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If it's really enumerated data types, that's fine, but this example was 
>about bitfield masks.

Ah.  In that case, enum is a pretty tortured way to declare it, though it 
does have the practical advantages over define that have been mentioned 
because the syntax is more rigorous.

The proper way to do bitfield masks is usually C bit field declarations, 
but I understand that tradition works even more strongly against using 
those than against using enum to declare enumerated types.

>there is _nothing_ wrong with using defines for constants.

I disagree with that; I find practical and, more importantly, 
philosophical reasons not to use defines for constants.  I'm sure you've 
heard the arguments; I just didn't want to let that statement go 
uncontested.

