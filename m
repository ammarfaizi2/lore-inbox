Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKAR4J>; Fri, 1 Nov 2002 12:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265629AbSKAR4J>; Fri, 1 Nov 2002 12:56:09 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:56104 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265587AbSKAR4I>; Fri, 1 Nov 2002 12:56:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 build failed with ACPI turned on
Date: Fri, 1 Nov 2002 20:02:38 +0100
User-Agent: KMail/1.4.3
References: <20021031194547.GA3555@hq.alert.sk>
In-Reply-To: <20021031194547.GA3555@hq.alert.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012002.38085.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 20:45, Robert Varga wrote:
> The structure declaration is protected by
>
> #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
>
> on line 640.

At the moment CONFIG_PM seems to be enabling APM, though it clearly does more than that. I think the config options for ACPI and APM should be sorted out sooner or later. Just enable Power Management and this should compile.

Jos

