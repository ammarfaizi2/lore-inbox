Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWJLPzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWJLPzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWJLPzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:55:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48062 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422725AbWJLPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:55:10 -0400
Subject: Re: Userspace process may be able to DoS kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 12 Oct 2006 11:56:05 -0400
Message-Id: <1160668565.24931.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 12:54 -0400, Günther Starnberger wrote:
> As most users who reported this problem are using Ubuntu,
> the problem may be related to one of the settings in Ubuntu's kernel
> config. The configuration of my kernel is also based on the Ubuntu
> kernel config. As I am not using the patched kernel by Ubuntu I hope
> that the LKML is the right place to report this issue. 

IIRC Ubuntu is the only major distro that ships with CONFIG_PREEMPT=y.
Any difference if you disable it?

Lee

