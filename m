Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272385AbRIFBpg>; Wed, 5 Sep 2001 21:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272375AbRIFBp0>; Wed, 5 Sep 2001 21:45:26 -0400
Received: from mx1.port.ru ([194.67.57.11]:11786 "EHLO smtp1.port.ru")
	by vger.kernel.org with ESMTP id <S272385AbRIFBpX>;
	Wed, 5 Sep 2001 21:45:23 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109060519.f865Ja106488@vegae.deep.net>
Subject: page pre-swapping + moving it on cache-list
To: riel@surriel.com
Date: Thu, 6 Sep 2001 05:19:35 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       Here is an idea i think i stole from Matthew Dillon`s paper.

    Actually it sound more like we take some pages from the near 0 
  age and swapping them out but not throwing them away, but moving them
  from active list to cache. So that we can always throw them away
  at near null cost while shrinking the cache. This is like a
  replacement for swap-cache if i`m right here...

cheers,
 Sam
   
