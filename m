Return-Path: <linux-kernel-owner+w=401wt.eu-S1425610AbWLHQk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425610AbWLHQk0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425609AbWLHQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:40:26 -0500
Received: from twin.jikos.cz ([213.151.79.26]:36754 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425611AbWLHQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:40:25 -0500
Date: Fri, 8 Dec 2006 17:38:47 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: parallel boot device initialisation (kernel-space not userspace)
In-Reply-To: <4758137481lkcl@lkcl.net>
Message-ID: <Pine.LNX.4.64.0612081737510.1665@twin.jikos.cz>
References: <4758137481lkcl@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Luke Kenneth Casson Leighton wrote:

> I Have A Great Idea(tm) and would like to describe it concisely to see 
> if anyone likes it and hopefully hasn't thought of it before so i'm not 
> consuming people's time. The idea is: parallel device initialisation of 
> built-in modules, to reduce kernel boot time.

Have you looked at CONFIG_PCI_MULTITHREAD_PROBE which is already present 
in recent kernels?

-- 
Jiri Kosina
