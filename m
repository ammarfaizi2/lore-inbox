Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTFBRNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTFBRNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:13:41 -0400
Received: from cs.columbia.edu ([128.59.16.20]:28854 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S264795AbTFBRNj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:13:39 -0400
From: Gong Su <gongsu@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Cc: corbet@lwn.net
Subject: Re: Linux 2.4.x block device driver question
Date: Mon, 02 Jun 2003 13:23:07 -0400
Organization: CS Dept., Columbia Univ.
Message-ID: <ia1ndvc7pbat22hi6bltaebj62o14hvk8f@4ax.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon, sorry I forgot to mention your name in the post and thank you
very much for the reply. I think your guess of the machine running out
of memory is correct; that's my guess too but I just don't understand
why it happened. I can understand the scenario you described but actually
I omitted some details in the post to keep it short. I actually disabled
the elevator algorithm by substituting in my own elevator_noop_merge
function that simply always returns ELEVATOR_NO_MERGE. So each request
will only have one buffer_head hanging off it (unless my naive idea of
disabling the elevator algorithm didn't work?). It helped to prolong
the life of the machine a little more but the machine still died
eventually. I'm really confused. Any idea at all? Thank you for your
time and sorry again forgetting to mention your name about the book.

-- 
/Gong
