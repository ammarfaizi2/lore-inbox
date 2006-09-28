Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWI1NZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWI1NZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWI1NZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:25:42 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:39326 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751875AbWI1NZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:25:42 -0400
Date: Thu, 28 Sep 2006 15:25:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: Re: [S390] hypfs sparse warnings.
Message-ID: <20060928132540.GA18933@wohnheim.fh-wedel.de>
References: <20060928130737.GB1120@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928130737.GB1120@skybase>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 September 2006 15:07:37 +0200, Martin Schwidefsky wrote:
> 
> sparse complains, if we use bitwise operations on enums. Cast enum to
> long in order to fix that problem!

At this point I start to wonder which part should be changed.  Is it
better to
a) cast some more, as you started to do,
b) change enums to #defines or
c) change '|' to '+'?

At any rate, you have the same problem in 5 seperate places by my
count and only changed 1 of them.  Nak - in case anyone cares.

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague.
-- Edsger W. Dijkstra
