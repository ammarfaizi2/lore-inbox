Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRIBR4X>; Sun, 2 Sep 2001 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRIBR4N>; Sun, 2 Sep 2001 13:56:13 -0400
Received: from mx4.port.ru ([194.67.57.14]:61457 "EHLO mx4.mail.ru")
	by vger.kernel.org with ESMTP id <S267196AbRIBR4H>;
	Sun, 2 Sep 2001 13:56:07 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109022218.f82MIFc04320@-f>
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 2 Sep 2001 22:18:09 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010902174454Z16091-32383+3013@humbolt.nl.linux.org> from "Daniel Phillips" at Sep 02, 2001 07:51:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Daniel Phillips wrote:
> Measurements where you force your system into continuous swapping would be very
> interesting.
      unfortunately under heavy load kernel starts to give out alot of errors:
Sep  2 11:46:38 vegae kernel: VM: __lru_cache_del, found unknown page ?!
Sep  2 11:47:01 vegae last message repeated 1023 times
Sep  2 11:58:10 vegae kernel: VM: __lru_cache_del, found unknown page ?!
Sep  2 11:58:45 vegae last message repeated 603 times
Sep  2 12:00:00 vegae kernel: VM: __lru_cache_del, found unknown page ?!
Sep  2 12:01:01 vegae last message repeated 2478 times
Sep  2 12:01:13 vegae last message repeated 389 times
Sep  2 12:01:13 vegae kernel: VM: __lru_cache_del, found unknown page ?!
Sep  2 12:01:22 vegae last message repeated 399 times
Sep  2 12:01:23 vegae kernel: VM: __lru_cache_del, found unknown page ?!
Sep  2 12:01:54 vegae last message repeated 959 times

page_remove_all_pmaps: SWAP_ERROR
try_to_swap_out: page not in a VMA?!
page_remove_all_pmaps: SWAP_ERROR
try_to_swap_out: page not in a VMA?!
page_remove_all_pmaps: SWAP_ERROR

     i already reported this to Rik
> --
> Daniel
> 

