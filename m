Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTKUOY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 09:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKUOY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 09:24:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264274AbTKUOY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 09:24:26 -0500
Date: Fri, 21 Nov 2003 09:24:16 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Steven Davy <sdavy@tssg.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IPsec AH failure over IPv6
In-Reply-To: <200311210909.51836.sdavy@tssg.org>
Message-ID: <Xine.LNX.4.44.0311210923500.18045-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Nov 2003, Steven Davy wrote:

> Im running performance tests using netperf (patched for ip6) across two 
> machines, ESP works great but AH works really bad, practally all the packets 
> are droped. Tcpdump reads the packets but they are not passed on to netperf. 
> Read somewhere the IPsec Ah doesent like fragmentation over tcp, but im not 
> sure. Im using manual keying, and the 2.5.75 kernel. Is there a kernel patch 
> to fix this!!

Please try a more recent kernel (like 2.6.0-test9).


- James
-- 
James Morris
<jmorris@redhat.com>


