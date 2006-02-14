Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWBNHfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWBNHfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWBNHfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:35:33 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51936 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750988AbWBNHfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:35:33 -0500
Date: Tue, 14 Feb 2006 09:35:30 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Carsten Otto <c-otto@gmx.de>
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
In-Reply-To: <20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de>
Message-ID: <Pine.LNX.4.58.0602140933380.15339@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI>
 <20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 12:16:22PM +0200, Pekka J Enberg wrote:
> > Does the following patch fix your problem?
 
On Mon, 13 Feb 2006, Carsten Otto wrote:
> Yes, it does (I moved to 2.6.15.4 in the same step, though).

This is also fixed in current git (bit differently by Andi):

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6bca52b544489b626c7d0db801df6b4aa3d5adb5

				Pekka
