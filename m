Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTKOVdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKOVdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:33:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18920 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262074AbTKOVdm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:33:42 -0500
Date: Sat, 15 Nov 2003 21:33:42 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115213342.GR24159@parcelfarce.linux.theplanet.co.uk>
References: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311152045310.743-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311152045310.743-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 08:50:55PM +0000, Tigran Aivazian wrote:
 
> Looking at mm/slab.c implementation I see that it just walks the integer 
> distance from the head of the list. Simple but not 100% correct, I think. 
> I.e. it can miss an entry if the list has changed between two read(2)s.

Define "miss".  What sort of warranties do you expect there?
