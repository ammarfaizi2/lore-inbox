Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTEFWF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbTEFWF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:05:58 -0400
Received: from holomorphy.com ([66.224.33.161]:31371 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261906AbTEFWF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:05:56 -0400
Date: Tue, 6 May 2003 15:18:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Another question about thrashing
Message-ID: <20030506221824.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB7C490.5040803@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB7C490.5040803@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:20:00AM -0400, Timothy Miller wrote:
> There didn't seem to be much interest in my earlier post about kernel 
> behavior when swap thrashing.
> So my question is, are we not concerned about system behavior when one 
> process uses so much memory that it grinds everything else to a halt?
> It appears that a thrashing process is being given more preferential 
> treatment than it should.

Design characteristic of global page replacement algorithms. It's not
getting touched for 2.5/2.6


-- wli
