Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTBRPRH>; Tue, 18 Feb 2003 10:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTBRPRH>; Tue, 18 Feb 2003 10:17:07 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:13069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267856AbTBRPRF>; Tue, 18 Feb 2003 10:17:05 -0500
Date: Tue, 18 Feb 2003 15:27:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kostadin Karaivanov <larry@minfin.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS problem 2.5.6{0,1,2}
Message-ID: <20030218152702.B16760@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
References: <002c01c2d751$a279a880$1504a8c0@minfin.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <002c01c2d751$a279a880$1504a8c0@minfin.bg>; from larry@minfin.bg on Tue, Feb 18, 2003 at 03:28:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 03:28:32PM +0200, Kostadin Karaivanov wrote:
> Oftenly I get errors something like ...
> "In memory data corruption ..... shuting down filesystem ide(0,3)" and
> linux halts. Reboot fixes the things.
> Sorry can't paste the proper error output.
> It happens when I try to erase a lots of small files or on shutdown.
> I can't reproduce this, but it happens for at least once a day.
> My whole linux partition is on XFS.
> As long as I can tell this is not present in 2.5.5{7,8,9}

Do you use blocksize smaller than your pagesize?

