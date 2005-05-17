Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVEQAjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVEQAjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 20:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEQAjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 20:39:19 -0400
Received: from graphe.net ([209.204.138.32]:30984 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261631AbVEQAjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 20:39:17 -0400
Date: Mon, 16 May 2005 17:39:13 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
In-Reply-To: <200505170433.59091.adobriyan@gmail.com>
Message-ID: <Pine.LNX.4.62.0505161737310.22102@graphe.net>
References: <200505162320.j4GNKDLN002527@shell0.pdx.osdl.net>
 <200505170433.59091.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Alexey Dobriyan wrote:

> On Tuesday 17 May 2005 03:21, akpm@osdl.org wrote:
> > From: Christoph Lameter <christoph@lameter.com>
> 
> > asm-generic/topology.h must also be included if CONFIG_NUMA is not set 
> > in order to provide the fall back pcibus_to_node function.
> 
> It should be "included if CONFIG_NUMA is set".

Where will we define the fallback functions for new functions to 
be added to topology.h?

> P. S.: alpha has the same "#ifdef #else #endif" pattern in asm/topology.h

ia64 and i386 do not. 


