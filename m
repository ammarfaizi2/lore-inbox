Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTK1OZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTK1OZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:25:19 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:62223 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262308AbTK1OZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:25:17 -0500
Date: Fri, 28 Nov 2003 15:24:52 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031128142452.GA4737@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128045854.GA1353@home.woodlands>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 10:28:54AM +0530, Apurva Mehta wrote:

> On 2.6.0-testx kernels, I have noticed that there are problems with
> GNU Parted. Parted says that the disk geometries reported by the
> kernel are incorrect.

Yes. Parted should be fixed not to complain.
There is no such thing as a "correct" disk geometry.
Roughly speaking the kernel no longer attempts to report anything,
so calling HDIO_GETGEO is useless (for this purpose).

Andries

