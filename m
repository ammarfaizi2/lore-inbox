Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSHHSiS>; Thu, 8 Aug 2002 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSHHSiS>; Thu, 8 Aug 2002 14:38:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36335 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317778AbSHHSiQ>; Thu, 8 Aug 2002 14:38:16 -0400
Subject: Re: fix CONFIG_HIGHPTE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, riel@imladris.surriel.com
In-Reply-To: <Pine.LNX.4.44L.0208081149410.2589-100000@duckman.distro.conectiva>
References: <Pine.LNX.4.44L.0208081149410.2589-100000@duckman.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 20:59:17 +0100
Message-Id: <1028836757.28883.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 15:51, Rik van Riel wrote:
> Linux isn't yet up to having 500 simultaneous interactive
> users, in fact I don't think it has ever been up to this
> situation.

It works suprisingly well. I know people who are doing it. It does not
work when those users are all running arbitarly large jobs. In most
conventional (non student compile) type setups 500 is fine. The O(1)
scheduler and highio are pretty essential as is a real I/O subsystem.

