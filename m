Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319399AbSIFU7g>; Fri, 6 Sep 2002 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSIFU57>; Fri, 6 Sep 2002 16:57:59 -0400
Received: from vitelus.com ([64.81.243.207]:62222 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S319397AbSIFU5t>;
	Fri, 6 Sep 2002 16:57:49 -0400
Date: Fri, 6 Sep 2002 14:02:14 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020906210214.GA25666@vitelus.com>
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com> <3D78E44E.5020107@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D78E44E.5020107@namesys.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 09:22:22PM +0400, Hans Reiser wrote:
> I think I prefer that we implement a repacker for reiser4 though, as 
> that, combined with delayed allocation, will be a balanced and thorough 
> solution.

How does current ReiserFS fare against extreme fragmentation? What
about XFS? Without trying to risk a flamewar, what Linux filesystems
are the most preventive of fragmentation?

The filesystem could make a huge difference on a machine like a mail
server...
