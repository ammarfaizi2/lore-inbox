Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWJQN2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWJQN2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWJQN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:28:49 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:2441 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750921AbWJQN2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:28:47 -0400
Date: Tue, 17 Oct 2006 22:59:36 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Yi CDL Yang <yyangcdl@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, binutils@sourceware.org,
       bug-binutils@gnu.org
Subject: Re: 2.6.19-rc2 has ld error for ppc64
Message-ID: <20061017132936.GF20843@bubble.grove.modra.org>
Mail-Followup-To: Yi CDL Yang <yyangcdl@cn.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	binutils@sourceware.org, bug-binutils@gnu.org
References: <4534BA77.6040400@cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4534BA77.6040400@cn.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 07:11:51PM +0800, Yi CDL Yang wrote:
> On building 2.6.19-rc2 on ppc64, ld always reports such an error:
> 
> ".text exceeds stub group size"

This is not an error.  It is just a warning that might help explain a
later error.  If the linker doesn't give any errors then the warning
may safely be ignored.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
