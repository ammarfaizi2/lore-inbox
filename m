Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbTCMQMW>; Thu, 13 Mar 2003 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262454AbTCMQMV>; Thu, 13 Mar 2003 11:12:21 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:58128
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262453AbTCMQMV>; Thu, 13 Mar 2003 11:12:21 -0500
Subject: Re: 2.5.64-mm6
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030313032615.7ca491d6.akpm@digeo.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047572586.1281.1.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 08:23:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 03:26, Andrew Morton wrote:
>   This means that when an executable is first mapped in, the kernel will
>   slurp the whole thing off disk in one hit.  Some IO changes were made to
>   speed this up.

Does this just pull in text and data, or will it pull any debug sections
too?  That could fill memory with a lot of useless junk.

	J

