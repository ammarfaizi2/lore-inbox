Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSHINNH>; Fri, 9 Aug 2002 09:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSHINNH>; Fri, 9 Aug 2002 09:13:07 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:64265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318256AbSHINNH>; Fri, 9 Aug 2002 09:13:07 -0400
Date: Fri, 9 Aug 2002 14:16:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Johan Martensson <a0087901@levonline.com>
Cc: linux-kernel@vger.kernel.org, jom@virrvarr.com
Subject: Re: 2.4.19 Oops :Unable to handle kernel paging request
Message-ID: <20020809141643.A10534@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Johan Martensson <a0087901@levonline.com>,
	linux-kernel@vger.kernel.org, jom@virrvarr.com
References: <20020809132447.A9306@infradead.org> <Pine.LNX.4.44.0208091502450.14539-100000@utter.levonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208091502450.14539-100000@utter.levonline.com>; from a0087901@levonline.com on Fri, Aug 09, 2002 at 03:10:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 03:10:47PM +0200, Johan Martensson wrote:
> I did. But when looking at the Oops output it seems to me that it is
> get_free_page() that fails. If that is correct then it shouldn't matter
> wether the call was made from grsecurity, should it? I thought
> get_free_page would be succesful as long as I have free memory in
> the system. 

get_free_page() is free to fail whenever it wants. 
