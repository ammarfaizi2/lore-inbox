Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310646AbSCLLtC>; Tue, 12 Mar 2002 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCLLsz>; Tue, 12 Mar 2002 06:48:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37902 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310646AbSCLLsl>;
	Tue, 12 Mar 2002 06:48:41 -0500
Date: Tue, 12 Mar 2002 11:48:35 +0000
From: wli@holomorphy.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312114835.B14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	wli@parcelfarce.linux.theplanet.co.uk,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312070645.X10413@dualathlon.random> <Pine.LNX.4.44L.0203120746000.2181-100000@imladris.surriel.com> <20020312124728.L25226@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020312124728.L25226@dualathlon.random>; from andrea@suse.de on Tue, Mar 12, 2002 at 12:47:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 12:47:28PM +0100, Andrea Arcangeli wrote:
> Bill said that "randomness" is not the right word to use, I instead
> think it's the key. If it's pure random mul will make no difference to
> the distribution. And the closer we're to pure random like in the
> wait_table hash, the less mul will help and the more important will be
> to just get right the two contigous pages in the same cacheline and
> nothing else.

Aha! It's random! Is the distribution:

(1) Poisson
(2) singular
(3) binomial
(4) hypergeometric

or what?


Cheers,
Bill
