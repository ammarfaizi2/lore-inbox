Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278831AbRJVOa7>; Mon, 22 Oct 2001 10:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278830AbRJVOat>; Mon, 22 Oct 2001 10:30:49 -0400
Received: from ns.ithnet.com ([217.64.64.10]:10765 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278832AbRJVOaf>;
	Mon, 22 Oct 2001 10:30:35 -0400
Date: Mon, 22 Oct 2001 16:30:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount of msdos fs?
Message-Id: <20011022163051.558d602e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.10.10110221014590.18541-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <20011022125928.2f2a15b9.skraw@ithnet.com>
	<Pine.LNX.4.10.10110221014590.18541-100000@coffee.psychology.mcmaster.ca>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 10:15:34 -0400 (EDT) Mark Hahn <hahn@physics.mcmaster.ca>
wrote:

> > I just found out, that msdos-type fs cannot be exported via nfs.
Disregarding
> > the security problems with msdos fs, how can I export it anyway via nfs? Is
> > this possible at all? I tried with 2.2.19 kernel and kernel nfs.
> 
> I'm guessing because msdos doesn't have inode numbers,
> and nfsd wants them to make stable cookies.

Works under 2.4, btw. Unfortunately I cannot use 2.4 in this special case. But
to make it clear:
server is 2.2.19, client is 2.4.4

Regards,
Stephan
