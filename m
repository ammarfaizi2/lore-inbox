Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTF2T2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTF2T2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:28:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:24200 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262299AbTF2T2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:28:08 -0400
Date: Sun, 29 Jun 2003 20:42:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, wowbagger@sktc.net
Subject: Re: File System conversion -- ideas
Message-ID: <20030629194213.GD26258@mail.jlokier.co.uk>
References: <200306291837.h5TIbsJi001136@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291837.h5TIbsJi001136@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> It's usually more flexible just to partition the space you need, and
> add more partitions when necessary.  For typical desktop use, swap
> isn't even necessary with 1 GB of physical RAM.

Partitions are never the right size when you fill one up.

I used to do what you describe, and got fed up when I had too many
strange symbolic links around, things like

	/var/www -> /disk2/www
	/var/log/httpd -> /disk2/httpd_logs
	/home/jamie -> /disk2/jamie
	/home/jamie/downloads -> /disk3/jamie_downloads

etc.

It seemed simpler to have one filesystem, and indeed it was.

(Now I have two drives at home I am back to the above, unfortunately.
At least the laptop is nice and simple, as it can only have 1 drive :)

Also, on a dedicated server I still use symbolic links between
partitions as it is too risky to try rearranging the partitions
remotely, and too expensive to rent more disk space.

-- Jamie
