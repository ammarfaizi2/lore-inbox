Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292662AbSCMHvy>; Wed, 13 Mar 2002 02:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSCMHvq>; Wed, 13 Mar 2002 02:51:46 -0500
Received: from mail.webmaster.com ([216.152.64.131]:52965 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S292658AbSCMHvh> convert rfc822-to-8bit; Wed, 13 Mar 2002 02:51:37 -0500
From: David Schwartz <davids@webmaster.com>
To: <ak@suse.de>, Brad Pepers <brad@linuxcanada.com>
CC: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Tue, 12 Mar 2002 23:51:29 -0800
In-Reply-To: <20020312081002.A14745@wotan.suse.de>
Subject: Re: Multi-threading
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020313075135.AAA25107@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Just it might change immediately afterwards if you don't remove the
>object from public view first.

	If it was in public view, whatever held it in public view would be using it, 
and hence its use count could not drop to zero.

	DS


