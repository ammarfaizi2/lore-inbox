Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268439AbTBYVrD>; Tue, 25 Feb 2003 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbTBYVrD>; Tue, 25 Feb 2003 16:47:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7945 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268439AbTBYVrC>; Tue, 25 Feb 2003 16:47:02 -0500
Date: Tue, 25 Feb 2003 21:57:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: atomic_t (24 bits???)
Message-ID: <20030225215715.H21014@flint.arm.linux.org.uk>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030225140554.20186A-100000@chaos> <20030225191711.GA25331@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225191711.GA25331@nevyn.them.org>; from dan@debian.org on Tue, Feb 25, 2003 at 02:17:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:17:11PM -0500, Daniel Jacobowitz wrote:
> There are other platforms where you can't reliably use the whole word. 
> Some ARM atomic_t implementations are like this, although I don't know
> if the one in the kernel is.

The ARM atomic_t isn't 24-bit - it's a full paid up member of the
32-bit club. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

