Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUACK4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 05:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUACK4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 05:56:09 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:55950 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S263057AbUACK4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 05:56:05 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 3 Jan 2004 11:20:04 +0100
User-Agent: KMail/1.5.2
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401022200.22917.ornati@lycos.it> <20040102213228.GH1882@matchmail.com>
In-Reply-To: <20040102213228.GH1882@matchmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401031041.36982.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 22:32, Mike Fedyk wrote:
> On Fri, Jan 02, 2004 at 10:04:27PM +0100, Paolo Ornati wrote:
> > NR_TESTS=3
> > RA_VALUES="64 128 256 8192"
>
> Can you add more samples between 128 and 256, maybe at intervals of 32?

YES

2.6.0:
128	31.66
160	31.88
192	30.93
224	31.18
256	26.16	# HD LED blinking

2.6.1-rc1:
128	25.91	# HD LED blinking
160	26.00	# HD LED blinking
192	26.06	# HD LED blinking
224	25.94	# HD LED blinking
256	25.96	# HD LED blinking

bye

-- 
	Paolo Ornati
	Linux v2.4.23


