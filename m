Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbTLaSJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTLaSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:09:06 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:18875 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265217AbTLaSJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:09:04 -0500
Date: Wed, 31 Dec 2003 10:08:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dale Blount <linux-kernel@dale.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] Server stops serving nfs files (possibly ext3 or quota related)
Message-ID: <20031231180858.GC1882@matchmail.com>
Mail-Followup-To: Dale Blount <linux-kernel@dale.us>,
	linux-kernel@vger.kernel.org
References: <1071827364.1518.39.camel@rock.dale.us> <1071948988.1521.59.camel@rock.dale.us> <1072883581.22782.8.camel@rock.dale.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072883581.22782.8.camel@rock.dale.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 10:13:01AM -0500, Dale Blount wrote:
> Since no one seems to have any ideas, could someone please tell me (or
> link to the docs) of what I need to capture next time this happens? 
> It's been pretty consistent from 2.4.18-ac4 to 2.4.22 so I'm figuring
> the problem still isn't resolved in 2.4.23.  I've been checking
> changelogs and nothing looks relevant.

First I'd cc ext3-users@redhat.com

If your processes are waiting on something you'll need to show what they're
waiting in (ps axl).

Do you get any other error messages in your kernel logs?  Does your network
connection keep working when NFS serving stops?

run sysrq+t at the time you're having the problem, and run it through
ksymoops.

Oh, and for small lists it's ok to just include it in the email body.

Mike
