Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVEHHqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVEHHqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 03:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVEHHqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 03:46:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43161 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262823AbVEHHqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 03:46:04 -0400
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency
	detection (2.6.12-rc3)
From: Lee Revell <rlrevell@joe-job.com>
To: Haoqiang Zheng <haoqiang@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 08 May 2005 03:46:02 -0400
Message-Id: <1115538362.19965.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-08 at 02:11 -0400, Haoqiang Zheng wrote:
> Certainly, this very problem can be solved by setting the priority of
> X to nice -10 (like what Redhat etc. does).

This just flips the priority inversion around: the nice -10 X server
will consume all available CPU rendering on behalf xscreensaver, running
at nice 20.

I would like to test this code very much, as this has been a real
problem for me.

Lee 

