Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSH0WMH>; Tue, 27 Aug 2002 18:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSH0WMH>; Tue, 27 Aug 2002 18:12:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:45831 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317298AbSH0WMG>; Tue, 27 Aug 2002 18:12:06 -0400
Date: Tue, 27 Aug 2002 23:16:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020827231625.A7961@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.40.0208272306480.21077-100000@ultra60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.40.0208272306480.21077-100000@ultra60>; from golbi@mat.uni.torun.pl on Tue, Aug 27, 2002 at 11:48:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 11:48:07PM +0200, Krzysztof Benedyczak wrote:
> Awaiting comments, feedbacks, etc. (especially about above two points)

The multiplexer syscall is horribly ugly. I'd suggest implementing it
as filesystems so each message queue object can be represented as file,
using defined file methods as much as possible.

