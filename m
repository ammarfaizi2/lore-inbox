Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319188AbSHTQix>; Tue, 20 Aug 2002 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319190AbSHTQiw>; Tue, 20 Aug 2002 12:38:52 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:49169 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319188AbSHTQiv>; Tue, 20 Aug 2002 12:38:51 -0400
Date: Tue, 20 Aug 2002 17:42:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: /proc/partitions in 2.4.20-pre3/4
Message-ID: <20020820174255.A30153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Oledzki <ole@ans.pl>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <Pine.LNX.4.33.0208201827510.22200-100000@dark.pcgames.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0208201827510.22200-100000@dark.pcgames.pl>; from ole@ans.pl on Tue, Aug 20, 2002 at 06:35:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 06:35:27PM +0200, Krzysztof Oledzki wrote:
> Hello :)
> 
> There is something wrong with /proc/partitions. It seems that last changes
> broken this file:
> 
> "cat /proc/partitions |wc -c"  shows that this file has 29167 bytes. First
> part of files has lot of \0 characters. With software raid enabled (not
> ataraid) it has all md0 - md255 devices (and not only used devices) and
> does not have informations for phisical disks (sdXX, hdXX).

The fix is in -ac.  Alan promised to send it for -pre3 but it seems he
didn't..

