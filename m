Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWEHOxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWEHOxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWEHOxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:53:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24199 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932340AbWEHOxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:53:18 -0400
Subject: Re: How to read BIOS information
From: Arjan van de Ven <arjan@infradead.org>
To: Madhukar Mythri <madhukar.mythri@wipro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445F5228.7060006@wipro.com>
References: <445F5228.7060006@wipro.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 16:53:13 +0200
Message-Id: <1147099994.2888.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 19:44 +0530, Madhukar Mythri wrote:
> Hi,
>      Im new to this group.
> I want to get some information from BIOS. i.e i want to know whether 
> Hyperthreading is Enabled/Disabled(as per BIOS settings)  from an user 
> applications program.

there is no standard way to do this. You can use /proc/cpuinfo to see if
the kernel found ht'd processors. But that's the best you can do.
(well you could grovel through the acpi tables just like the kernel
does, but you really don't want to do that from userspace)

