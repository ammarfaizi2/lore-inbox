Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTETAN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTETAN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:13:57 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:49036 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S262568AbTETAN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:13:56 -0400
Date: Mon, 19 May 2003 20:26:53 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 'strchr' warning from reiserfs
Message-ID: <20030520002653.GE21836@kurtwerks.com>
References: <20030517191611.GA10417@mars.ravnborg.org> <20030519124712.2c4b692d.shemminger@osdl.org> <20030519213315.GA1069@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519213315.GA1069@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-xfs
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An unnamed Administration source, Sam Ravnborg, wrote:
% On Mon, May 19, 2003 at 12:47:12PM -0700, Stephen Hemminger wrote:
% > 
% > Is this gcc behaviour documented anywhere?
% 
% I dropped a mail to gcc-bugs - the reply was:
% 
% =======
% The kernel is a special case; GCC is entitled to assume the existence of
% standard C library functions.
% =======
% 
% So when messing with standard functions we may expect a few suprises,
% which I think is fair enough.

Hmm. And -nostdlib (or -nodefaultlibs) doesn't catch it?

K
-- 
According to Kentucky state law, every person must take a bath at least
once a year.
