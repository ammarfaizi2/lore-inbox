Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293441AbSBZBtn>; Mon, 25 Feb 2002 20:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSBZBti>; Mon, 25 Feb 2002 20:49:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54474 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293441AbSBZBtY>; Mon, 25 Feb 2002 20:49:24 -0500
Date: Mon, 25 Feb 2002 17:49:43 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <10350000.1014688183@flay>
In-Reply-To: <Pine.LNX.4.33L.0202252238250.7820-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202252238250.7820-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Making the locking more scaleable wrt. the pagemap_lru_lock
> could be either a simple change or a rework of the way the
> VM does locking. I'm not sure which way to go...

If the simple change works, it would be cool to see that as
a first step (I sent you a simplistic patch, but I'm not at all sure
it's correct). Breaking up that lock might expose something
else that people could work on in the meantime ....

M.

