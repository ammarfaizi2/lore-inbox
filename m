Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSBHIyN>; Fri, 8 Feb 2002 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291479AbSBHIyC>; Fri, 8 Feb 2002 03:54:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64268 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291477AbSBHIx4>;
	Fri, 8 Feb 2002 03:53:56 -0500
Date: Fri, 8 Feb 2002 09:53:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM 12d
Message-ID: <20020208095335.I4942@suse.de>
In-Reply-To: <Pine.LNX.4.33L.0202072127490.17850-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202072127490.17850-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Rik van Riel wrote:
>   - fix starvation issue in get_request_wait()

I'm currently fixing this (non-trivial) problem in 2.5, I'll do a 2.4
back port afterwards. Hopefully with the same structure, if it doesn't
become too big a change.

-- 
Jens Axboe

