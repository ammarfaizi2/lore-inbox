Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUAEWXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbUAEWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:21:51 -0500
Received: from findaloan.ca ([66.11.177.6]:41166 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S265975AbUAEWUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:20:30 -0500
Date: Mon, 5 Jan 2004 17:18:40 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Andreas Schwab <schwab@suse.de>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105221840.GA3222@mark.mielke.cc>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com> <200401042148.24742.rob@landley.net> <20040105151303.GA30849@mark.mielke.cc> <jey8smmjye.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jey8smmjye.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:36:09PM +0100, Andreas Schwab wrote:
> Mark Mielke <mark@mark.mielke.cc> writes:
> > There are a few cases that we might be forced to maintain regular
> > numbers: mkfifo() creates a named pipe, and bind() creates a named
> > socket.
> Neither fifos nor sockets are devices.

Well, then, as long as things like this don't break... :-)

Other than backing up /dev, does anybody have *real* cases where a
program assumes major:minor is consistent across reboots? We should
start notifying the authors now... NFS seems to be one, given the
explanation offered for how fsid's are derived...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

