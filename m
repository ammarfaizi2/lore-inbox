Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTJNBjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJNBjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:39:39 -0400
Received: from [217.7.64.198] ([217.7.64.198]:40126 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S262130AbTJNBji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:39:38 -0400
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI in -pre7 builds with -Os
Date: Tue, 14 Oct 2003 03:39:35 +0200
User-Agent: KMail/1.5.4
References: <20031013231413.GA4189@werewolf.able.es>
In-Reply-To: <20031013231413.GA4189@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310140339.36445.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 14. Oktober 2003 01:14, J.A. Magallon wrote:
> Hi all...
>
> $subject:
>
> drivers/acpi/Makefile:
>
> ACPI_CFLAGS := -Os
>
> Uh ?

Looks like a bug. And a missing feature.

- ACPI_CFLAGS := -Os
+ ACPI_CFLAGS := -Os --bzip2

