Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135625AbREBQdL>; Wed, 2 May 2001 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135630AbREBQdC>; Wed, 2 May 2001 12:33:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60012 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135623AbREBQcr>; Wed, 2 May 2001 12:32:47 -0400
To: "Alex Huang" <alexjoy@sis.com.tw>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: How can do to disable the L1 cache in linux ?
In-Reply-To: <00a601c0d2b4$a8571740$d9d113ac@sis.com.tw>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2001 10:30:39 -0600
In-Reply-To: "Alex Huang"'s message of "Wed, 2 May 2001 11:04:52 +0800"
Message-ID: <m1itjjpvbk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Huang" <alexjoy@sis.com.tw> writes:

> Dear All,
>  How can do to disable the L1 cache in linux ?
> Are there some commands or directives to disable it ??

Play with the MTRR's and disable caching on memory.

Stupid but it should get what you want.

Eric
