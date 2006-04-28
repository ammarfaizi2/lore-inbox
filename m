Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWD1Ts7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWD1Ts7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWD1Ts7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:48:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30413 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751438AbWD1Ts6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:48:58 -0400
Date: Fri, 28 Apr 2006 14:48:46 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Pat Gefre <pfg@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 Altix : correct ioc3 port order
In-Reply-To: <200604281931.k3SJVBjR063404@fsgi900.americas.sgi.com>
Message-ID: <20060428144745.O67051@chenjesu.americas.sgi.com>
References: <200604281931.k3SJVBjR063404@fsgi900.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, Pat Gefre wrote:

> Currently loading the ioc3 as a module will cause the ports to be
> numbered in reverse order. This mod maintains the proper order of cards
> for port numbering.

Pat,

Since the sn/ioc3.c code came from sn/ioc4.c, do we have the same
problem there as well?

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
