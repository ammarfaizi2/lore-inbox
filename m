Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTGGKgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTGGKgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:36:41 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:59633 "EHLO
	rhenium.btinternet.com") by vger.kernel.org with ESMTP
	id S264880AbTGGKgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:36:40 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 11:51:12 +0100
User-Agent: KMail/1.5.2
References: <200307070317.11246.kernel@kolivas.org> <1057516609.818.4.camel@teapot.felipe-alfaro.com> <200307071319.57511.kernel@kolivas.org>
In-Reply-To: <200307071319.57511.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071151.12553.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Aha!
>
> Thanks to Felipe who picked this up I was able to find the one bug causing
> me grief. The idle detection code was allowing the sleep_avg to get to
> ridiculously high levels. This is corrected in the following replacement
> O3int patch. Note this fixes the mozilla issue too. Kick arse!!
>
> Con

Just booted with patch-O3int-0307071315 on top of 2.5.74-mm2 and the mouse 
stuttering under high CPU load has gone and no audio skipping.

Truly brilliant work

Thank you

Nick

