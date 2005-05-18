Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVERAIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVERAIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVERAIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:08:49 -0400
Received: from graphe.net ([209.204.138.32]:51207 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261748AbVERAI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:08:28 -0400
Date: Tue, 17 May 2005 17:08:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
In-Reply-To: <428A8697.4010606@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505171707100.18365@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
 <428A8697.4010606@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Matthew Dobson wrote:

> Not a big fan of this patch.  It's not wrong, per-se, but it just doesn't
> sit right with me.  asm-generic/topology.h should be a fallback file for
> the arches that just want some sort of sane UP/SMP defaults.  The better
> (IMHO) solution is this patch.  Builds fine on PPC64.

And what happens if yet another function needs to be added for all arches? 
Then ppc64 will break again and you will fix it again?

