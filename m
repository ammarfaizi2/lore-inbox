Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291355AbSB0BmV>; Tue, 26 Feb 2002 20:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291348AbSB0BmN>; Tue, 26 Feb 2002 20:42:13 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62710
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291372AbSB0BmA>; Tue, 26 Feb 2002 20:42:00 -0500
Date: Tue, 26 Feb 2002 17:42:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nicholas Kirsch <nkirsch@insynq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible freeze on 2.4.18
Message-ID: <20020227014235.GT4393@matchmail.com>
Mail-Followup-To: Nicholas Kirsch <nkirsch@insynq.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16fsnE-0005RR-00@ark.dev.insynq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16fsnE-0005RR-00@ark.dev.insynq.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 05:22:04PM -0800, Nicholas Kirsch wrote:
> Help! Using 2.4.18 (and verified as far back as .9) - I am getting a process freeze when an application does an fsync. Turning off HIGHMEM (the box has 2GB ram) solves the issue. Is there anyone who is interested in learning more about this situation? Please CC to nkirsch@insynq.com. 

Please try the -aa kernel patch series.

Also, many people including myself have had better responce from -rmap, but
you should probably give -aa a try first.

Mike
