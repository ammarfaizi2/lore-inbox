Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272582AbRILULQ>; Wed, 12 Sep 2001 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272588AbRILUK4>; Wed, 12 Sep 2001 16:10:56 -0400
Received: from mx10.port.ru ([194.67.57.20]:23432 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S272582AbRILUKt>;
	Wed, 12 Sep 2001 16:10:49 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109130033.f8D0XPw00866@vegae.deep.net>
Subject: tail corruptions: saga continues
To: reiser@namesys.com
Date: Thu, 13 Sep 2001 00:33:23 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         2.4.7/3.x.0k-pre8 pair in _very_rare_ circumsistances
    gives tails corruptions with --rebuild-tree.
    Actually i found only one file filled with "." (ofcourse <4k)
         As a detail, on sudden reboots i have log tails filled with "."
    but it seems to be unrelated.
         It may look like this one file "." fill was caused by sudden
    inability to sync while corruption raised, but in fact at the moment
    when fs was corrupted i havent accessed this file for ages... (.c file)

Cheers, Samium Gromoff

