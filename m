Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310829AbSCLM1c>; Tue, 12 Mar 2002 07:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310868AbSCLM1W>; Tue, 12 Mar 2002 07:27:22 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:41109 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310829AbSCLM1J>;
	Tue, 12 Mar 2002 07:27:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.19pre2aa1
Date: Tue, 12 Mar 2002 13:21:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        phillips@bonn-fries.net
In-Reply-To: <20020312070645.X10413@dualathlon.random> <Pine.LNX.4.44L.0203120746000.2181-100000@imladris.surriel.com> <20020312124728.L25226@dualathlon.random>
In-Reply-To: <20020312124728.L25226@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16klHb-0001up-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 12:47 pm, Andrea Arcangeli wrote:
> If it's pure random mul will make no difference to
> the distribution. And the closer we're to pure random like in the
> wait_table hash, the less mul will help and the more important will be
> to just get right the two contigous pages in the same cacheline and
> nothing else.

You're ignoring the possibility (probability) of corner cases.  I'm not
sure why you're beating away on this, Bill has done a fine job of coming
up with hashes that are both satisfactory for the common case and have
sound reasons for being resistant to corner cases.

-- 
Daniel
